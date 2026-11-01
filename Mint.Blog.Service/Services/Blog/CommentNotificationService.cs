using System.Text.Encodings.Web;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Mint.Blog.Common.Email;
using Mint.Blog.Model.Options;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class CommentNotificationService(ICommentRepository comments, IBlogSettingRepository settings, IEmailSender emailSender, IOptions<CommentNotificationOptions> options, ILogger<CommentNotificationService> logger) : ICommentNotificationService {
    public async Task NotifyCommentPublishedAsync(long commentId, CancellationToken cancellationToken = default) {
        var comment = CommentReadNormalizer.Normalize(await comments.GetAsync(commentId, cancellationToken: cancellationToken));
        var setting = await settings.GetAsync(cancellationToken);
        if (comment is null || setting is null) return;
        var domain = options.Value.Domain;
        if (comment.ReplyCommentId.HasValue && comment.Status == 2) {
            var reply = CommentReadNormalizer.Normalize(await comments.GetAsync(comment.ReplyCommentId.Value, cancellationToken: cancellationToken));
            if (reply is null || string.IsNullOrWhiteSpace(reply.Mail)) return;
            var title = $"你在{setting.Name}的评论收到了回复";
            var html = $"<html><body><h2>你的评论:</h2><p>{reply.Content}</p><h2>{comment.Nickname} 回复了你:</h2><p>{comment.Content}</p><p><a href='{CommentUrl(domain, reply.RouterUrl)}' target='_blank'>查看详情</a></p></body></html>";
            await TrySendAsync(reply.Mail, title, html, cancellationToken);
            return;
        }
        if (string.IsNullOrWhiteSpace(setting.Mail)) return;
        var authorTitle = $"{setting.Name}收到了评论";
        if (setting.IsCommentExamineOpen && comment.Status == 1) authorTitle += "【待审核】";
        if (setting.IsCommentSensitiveWordOpen && comment.Status == 3) authorTitle += "【系统已拦截】";
        var authorHtml = $"<html><body><h2>路由:</h2><p>{comment.RouterUrl}</p><h2>{comment.Nickname} 评论了你:</h2><p>{comment.Content}</p><p><a href='{CommentUrl(domain, comment.RouterUrl)}' target='_blank'>查看详情</a></p></body></html>";
        await TrySendAsync(setting.Mail, authorTitle, authorHtml, cancellationToken);
    }
    public async Task NotifyCommentExaminedAsync(long commentId, CancellationToken cancellationToken = default) {
        var comment = CommentReadNormalizer.Normalize(await comments.GetAsync(commentId, cancellationToken: cancellationToken));
        var setting = await settings.GetAsync(cancellationToken);
        if (comment is null || setting is null || string.IsNullOrWhiteSpace(comment.Mail)) return;
        var domain = options.Value.Domain;
        if (comment.Status == 3) {
            var title = $"你在{setting.Name}的评论未被审核通过";
            var html = $"<html><body><h2>你的评论:</h2><p>{comment.Content}</p><h2>审核未通过原因:</h2><p>{comment.Reason}</p><p><a href='{CommentUrl(domain, comment.RouterUrl)}' target='_blank'>查看详情</a></p></body></html>";
            await TrySendAsync(comment.Mail, title, html, cancellationToken);
            return;
        }
        if (comment.Status != 2) return;
        var approveTitle = $"你在{setting.Name}的评论已被审核通过";
        var approveHtml = $"<html><body><h2>你的评论:</h2><p>{comment.Content}</p><p><a href='{CommentUrl(domain, comment.RouterUrl)}' target='_blank'>查看详情</a></p></body></html>";
        await TrySendAsync(comment.Mail, approveTitle, approveHtml, cancellationToken);
        if (!comment.ReplyCommentId.HasValue) return;
        var reply = CommentReadNormalizer.Normalize(await comments.GetAsync(comment.ReplyCommentId.Value, cancellationToken: cancellationToken));
        if (reply is null || string.IsNullOrWhiteSpace(reply.Mail)) return;
        var replyTitle = $"你在{setting.Name}的评论收到了回复";
        var replyHtml = $"<html><body><h2>你的评论:</h2><p>{reply.Content}</p><h2>{comment.Nickname} 回复了你:</h2><p>{comment.Content}</p><p><a href='{CommentUrl(domain, reply.RouterUrl)}' target='_blank'>查看详情</a></p></body></html>";
        await TrySendAsync(reply.Mail, replyTitle, replyHtml, cancellationToken);
    }
    private static string CommentUrl(string domain, string routerUrl) {
        // RouterUrl is also the persisted comment lookup key; only translate the notification link.
        var path = routerUrl.StartsWith("/blog/surfer/article/", StringComparison.Ordinal)
            ? "/articles/" + routerUrl["/blog/surfer/article/".Length..]
            : routerUrl.StartsWith("/blog/surfer/column/", StringComparison.Ordinal)
                ? "/columns/" + routerUrl["/blog/surfer/column/".Length..]
                : routerUrl;
        return HtmlEncoder.Default.Encode(domain.TrimEnd('/') + "/" + path.TrimStart('/'));
    }
    private async Task TrySendAsync(string to, string title, string html, CancellationToken ct) {
        try { await emailSender.SendHtmlAsync(to, title, html, ct); }
        catch (Exception exception) { logger.LogError(exception, "Failed to send comment notification email. to={To}, title={Title}", to, title); }
    }
}
