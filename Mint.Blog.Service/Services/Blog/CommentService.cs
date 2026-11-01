using System.Net.Mail;
using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Model.Entitys.Blog.Comment;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Comment;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class CommentService(ICommentRepository repository, IBlogSettingRepository settings, ISensitiveWordService sensitiveWords, ICommentNotificationQueue notifications) : ICommentService {
    public async Task<PublishCommentResult> PublishAsync(PublishCommentCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.Nickname), ErrorCodes.CommentNicknameInvalid, "Nickname is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.Mail), ErrorCodes.CommentMailInvalid, "Mail is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.RouterUrl), ErrorCodes.CommentRouterUrlInvalid, "Router url is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.Content), ErrorCodes.CommentContentInvalid, "Content is required.");
        var website = command.Website?.Trim() ?? string.Empty;
        Guard.Against(website.Length > 0 && (!Uri.TryCreate(website, UriKind.Absolute, out var uri) || (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps)), ErrorCodes.CommentWebsiteInvalid, "请输入完整的网址（以 http:// 或 https:// 开头），或留空");
        var setting = await settings.GetAsync(cancellationToken);
        var nickname = command.Nickname.Trim();
        Guard.Against(nickname.Length > 50, ErrorCodes.CommentNicknameInvalid, "Nickname is invalid.");
        var mail = command.Mail.Trim();
        Guard.Against(!MailAddress.TryCreate(mail, out _), ErrorCodes.CommentMailInvalid, "Mail format is invalid.");
        var content = command.Content.Trim();
        Guard.Against(content.Length > 120, ErrorCodes.CommentContentInvalid, "Content length must be less than or equal to 120.");
        var status = setting?.IsCommentExamineOpen == true ? 1 : 2;
        var reason = string.Empty;
        if (setting?.IsCommentSensitiveWordOpen == true) {
            var words = sensitiveWords.FindMatchedWords(content);
            if (words.Count > 0) { status = 3; reason = $"系统自动拦截，包含敏感词：[{string.Join(", ", words)}]"; }
        }
        var now = DateTimeOffset.UtcNow;
        var comment = new CommentDataModel { Content = content, Avatar = command.Avatar.Trim(), Nickname = nickname, Mail = mail, Website = website, RouterUrl = command.RouterUrl.Trim(), ReplyCommentId = command.ReplyCommentId, ParentCommentId = command.ParentCommentId, Status = status, Reason = reason, CreatedAt = now, UpdatedAt = now };
        var id = await repository.AddAsync(comment, cancellationToken);
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(id);
        await notifications.EnqueueAsync(new(CommentNotificationKind.Published, id), cancellationToken);
        return status switch {
            3 => new(false, ErrorCodes.CommentContainsSensitiveWord, "评论内容中包含敏感词，请重新编辑后再提交"),
            1 => new(false, ErrorCodes.CommentWaitExamine, "评论已提交, 等待博主审核通过"),
            _ => new(true)
        };
    }
    public async Task ExamineAsync(ExamineCommentCommand command, CancellationToken cancellationToken = default) {
        var comment = CommentReadNormalizer.Normalize(await repository.GetAsync(command.Id, cancellationToken: cancellationToken));
        Guard.Against(comment is null, ErrorCodes.CommentNotFound, "Comment does not exist.");
        Guard.Against(command.Status is not 2 and not 3, ErrorCodes.CommentStatusInvalid, "Comment status is invalid.");
        comment!.Status = command.Status;
        comment.Reason = command.Status == 3 ? command.Reason?.Trim() ?? string.Empty : string.Empty;
        comment.UpdatedAt = DateTimeOffset.UtcNow;
        await repository.UpdateAsync(comment, cancellationToken);
        await notifications.EnqueueAsync(new(CommentNotificationKind.Examined, comment.Id), cancellationToken);
    }
    public async Task DeleteAsync(DeleteCommentCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.DeleteType is not 1 and not 2 and not 3, ErrorCodes.DeleteTypeInvalid, "Delete type is invalid.");
        var comment = CommentReadNormalizer.Normalize(await repository.GetAsync(command.Id, true, cancellationToken));
        Guard.Against(comment is null, ErrorCodes.CommentNotFound, "Comment does not exist.");
        if (command.DeleteType is 1 or 3) {
            var deleted = command.DeleteType == 1 ? (short)1 : (short)0;
            if (comment!.IsDeleted != deleted) { comment.IsDeleted = deleted; comment.UpdatedAt = DateTimeOffset.UtcNow; }
            await repository.UpdateAsync(comment, cancellationToken);
            return;
        }
        await DeleteOneAsync(command.Id, cancellationToken);
        var all = await repository.GetAllAsync(cancellationToken);
        CommentReadNormalizer.NormalizeAll(all);
        var children = all.Where(x => x.ReplyCommentId == command.Id).OrderByDescending(x => x.CreatedAt).ToArray();
        if (comment!.ReplyCommentId is null) {
            foreach (var child in all.Where(x => x.ParentCommentId == command.Id)) await DeleteOneAsync(child.Id, cancellationToken);
            return;
        }
        foreach (var child in children) { await DeleteOneAsync(child.Id, cancellationToken); await DeleteChildrenAsync(child.Id, cancellationToken); }
    }
    private async Task DeleteOneAsync(long id, CancellationToken ct) {
        var row = await repository.GetAsync(id, cancellationToken: ct);
        if (row is null) return;
        row.IsDeleted = 1;
        row.UpdatedAt = DateTimeOffset.UtcNow;
        await repository.UpdateAsync(row, ct);
    }
    private async Task DeleteChildrenAsync(long id, CancellationToken ct) {
        var all = await repository.GetAllAsync(ct);
        CommentReadNormalizer.NormalizeAll(all);
        foreach (var child in all.Where(x => x.ReplyCommentId == id).OrderByDescending(x => x.CreatedAt)) {
            await DeleteOneAsync(child.Id, ct);
            await DeleteChildrenAsync(child.Id, ct);
        }
    }
    public async Task<CommentListDto> GetAsync(GetCommentListQuery query, CancellationToken cancellationToken = default) {
        var all = await repository.GetNormalAsync(query.RouterUrl, cancellationToken);
        CommentReadNormalizer.NormalizeAll(all);
        if (all.Count == 0) return new(0, null);
        var items = all.Where(x => x.ParentCommentId is null).OrderByDescending(x => x.CreatedAt).Select(parent => {
            var children = all.Where(x => x.ParentCommentId == parent.Id).OrderBy(x => x.CreatedAt).Select(child =>
                new CommentItemDto(child.Id, child.Avatar, child.Nickname, child.Website, child.Content, child.CreatedAt,
                    child.ReplyCommentId != parent.Id ? all.FirstOrDefault(x => x.Id == child.ReplyCommentId)?.Nickname : null, [], false)).ToArray();
            return new CommentItemDto(parent.Id, parent.Avatar, parent.Nickname, parent.Website, parent.Content, parent.CreatedAt, null, children, false);
        }).ToArray();
        return new(all.Count, items);
    }
    public async Task<PagedResult<AdminCommentPageItemDto>> GetAsync(GetAdminCommentPageListQuery query, CancellationToken cancellationToken = default) {
        query = query with { PageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber, PageSize = query.PageSize <= 0 ? 10 : query.PageSize };
        var start = query.StartDate?.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
        var end = query.EndDate?.ToDateTime(TimeOnly.MaxValue, DateTimeKind.Utc);
        var page = await repository.GetPageAsync(query, start, end, cancellationToken);
        var items = page.Items.Select(x => new AdminCommentPageItemDto(x.Id, x.RouterUrl, x.Avatar, x.Nickname, x.Mail, x.Website, x.CreatedAt, x.Content, x.Status, x.Reason, x.IsDeleted != 0)).ToArray();
        return new(items, query.PageNumber, query.PageSize, page.Total);
    }
}
