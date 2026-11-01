using System.Text.RegularExpressions;
using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed partial class ArticleDraftService(IArticleDraftRepository drafts, IArticleRepository articles,
    IResourceRepository resources, IArticleImageStorage storage, ArticleTagVersionService tagVersions,
    IUnitOfWork unitOfWork) : IArticleDraftService {
    public Task<PagedResult<ArticleDraftListItemDto>> GetListAsync(int pageNumber, int pageSize, CancellationToken cancellationToken = default) =>
        drafts.GetListAsync(Math.Max(1, pageNumber), Math.Clamp(pageSize, 1, 100), cancellationToken);
    public async Task<ArticleDraftDto?> GetByIdAsync(long draftId, CancellationToken cancellationToken = default) {
        cancellationToken.ThrowIfCancellationRequested();
        return await ReadAsync(await drafts.GetAsync(draftId), cancellationToken);
    }
    public async Task<ArticleDraftDto?> GetByArticleIdAsync(long articleId, CancellationToken cancellationToken = default) {
        cancellationToken.ThrowIfCancellationRequested();
        return await ReadAsync(await drafts.GetByArticleAsync(articleId), cancellationToken);
    }
    private async Task<ArticleDraftDto?> ReadAsync(ArticleDraftDataModel? row, CancellationToken ct) {
        if (row?.TagId is long tagId) await drafts.EnsureGeneralVersionAsync(tagId, ct);
        return row is null ? null : await drafts.GetDetailAsync(row);
    }
    public async Task<long> SaveAsync(SaveArticleDraftCommand command, CancellationToken cancellationToken = default) {
        var articleId = ParseId(command.ArticleId);
        var requestedDraftId = ParseId(command.DraftId);
        Guard.Against(command.Visibility is not (1 or 2), ErrorCodes.ArticleContentInvalid, "Article visibility must be 1 or 2.");
        long id;
        IReadOnlyCollection<string> removed = [];
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var snapshot = requestedDraftId.HasValue ? await drafts.GetAsync(requestedDraftId.Value)
                : articleId.HasValue ? await drafts.GetByArticleAsync(articleId.Value) : null;
            Guard.Against(requestedDraftId.HasValue && snapshot is null, ErrorCodes.ArticleDraftNotFound, "Article draft does not exist.");
            Guard.Against(snapshot is not null && snapshot.ArticleId != articleId, "draft_article_changed", "不能更改草稿对应的文章。");
            var articleSnapshot = articleId.HasValue ? await articles.GetByIdAsync(articleId.Value, cancellationToken) : null;
            Guard.Against(articleId.HasValue && (articleSnapshot is null || articleSnapshot.IsDeleted != 0), ErrorCodes.ArticleNotFound, "Article does not exist.");
            var tags = new long?[] { snapshot?.TagId, command.TagId, articleSnapshot?.TagId }.Where(x => x.HasValue).Select(x => x!.Value).ToArray();
            await resources.LockTagsAsync(tags, cancellationToken, true);
            await tagVersions.ValidateAsync(command.TagId, command.TagVersionId, true, cancellationToken);
            if (articleId.HasValue) {
                await LockArticleAsync(articleId.Value, cancellationToken);
                var article = await articles.GetByIdAsync(articleId.Value, cancellationToken);
                CheckArticle(article, articleSnapshot!);
                if (snapshot is null)
                    Guard.Against(await drafts.ExistsByArticleAsync(articleId.Value), "draft_changed", "草稿已被创建，请刷新重试。");
            }
            var existing = snapshot;
            if (snapshot is not null) {
                await LockDraftAsync(snapshot.Id, cancellationToken);
                existing = await drafts.GetAsync(snapshot.Id);
                CheckDraft(existing, snapshot);
                var old = await drafts.GetDetailAsync(existing!);
                removed = Images(old.Content, old.Cover).Except(Images(Normalize(command.Content), Normalize(command.Cover)), StringComparer.OrdinalIgnoreCase).ToArray();
            }
            var now = DateTimeOffset.UtcNow;
            var row = existing ?? new ArticleDraftDataModel { ArticleId = articleId, CreatedAt = now };
            row.Title = Normalize(command.Title);
            row.Summary = Normalize(command.Summary);
            row.Cover = Normalize(command.Cover);
            row.TagId = command.TagId;
            row.TagVersionId = command.TagVersionId;
            row.Visibility = command.Visibility;
            row.UpdatedAt = now;
            id = await drafts.SaveAsync(row, existing is null, Normalize(command.Content));
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
        await CleanImagesAsync(removed, cancellationToken);
        return id;
    }
    public async Task<long> PublishAsync(long draftId, CancellationToken cancellationToken = default) {
        long articleId;
        IReadOnlyCollection<string> removed = [];
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var snapshot = await drafts.GetAsync(draftId);
            Guard.Against(snapshot is null, ErrorCodes.ArticleDraftNotFound, "Article draft does not exist.");
            var articleSnapshot = snapshot!.ArticleId.HasValue ? await articles.GetByIdAsync(snapshot.ArticleId.Value, cancellationToken) : null;
            Guard.Against(snapshot.ArticleId.HasValue && (articleSnapshot is null || articleSnapshot.IsDeleted != 0), ErrorCodes.ArticleNotFound, "Article does not exist.");
            await resources.LockTagsAsync(new long?[] { snapshot.TagId, articleSnapshot?.TagId }.Where(x => x.HasValue).Select(x => x!.Value), cancellationToken, true);
            await tagVersions.ValidateAsync(snapshot.TagId, snapshot.TagVersionId, false, cancellationToken);
            if (snapshot.ArticleId.HasValue) await LockArticleAsync(snapshot.ArticleId.Value, cancellationToken);
            await LockDraftAsync(draftId, cancellationToken);
            var row = await drafts.GetAsync(draftId);
            CheckDraft(row, snapshot);
            var draft = await drafts.GetDetailAsync(row!);
            var title = Normalize(draft.Title);
            var summary = Normalize(draft.Summary);
            var content = Normalize(draft.Content);
            var cover = Normalize(draft.Cover);
            Guard.Against(title.Length == 0, ErrorCodes.ArticleTitleInvalid, "Article title is required.");
            Guard.Against(summary.Length == 0 || summary.Length > 160, ErrorCodes.ArticleSummaryInvalid, "Article summary must contain 1 to 160 characters.");
            Guard.Against(content.Length == 0, ErrorCodes.ArticleContentInvalid, "Article content is required.");
            Guard.Against(cover.Length == 0, ErrorCodes.ArticleCoverInvalid, "Article cover is required.");
            Guard.Against(draft.Visibility is not (1 or 2), ErrorCodes.ArticleContentInvalid, "Article visibility must be 1 or 2.");
            if (draft.ArticleId.HasValue) {
                articleId = draft.ArticleId.Value;
                var article = await articles.GetByIdAsync(articleId, cancellationToken);
                CheckArticle(article, articleSnapshot!);
                removed = Images(article!.Content, article.Cover).Except(Images(content, cover), StringComparer.OrdinalIgnoreCase).ToArray();
                ArticleService.UpdateArticle(article, title, summary, content, cover, draft.TagId!.Value, draft.TagVersionId!.Value, draft.Visibility);
                await articles.UpdateAsync(article, cancellationToken);
            } else {
                var article = ArticleService.CreateArticle(title, summary, content, cover, draft.TagId!.Value, draft.TagVersionId!.Value, draft.Visibility);
                articleId = await articles.AddAsync(article, cancellationToken);
            }
            await drafts.DeleteAsync(draftId);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
        await CleanImagesAsync(removed, cancellationToken);
        return articleId;
    }
    public async Task DeleteAsync(long draftId, CancellationToken cancellationToken = default) {
        IReadOnlyCollection<string> images;
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var snapshot = await drafts.GetAsync(draftId);
            Guard.Against(snapshot is null, ErrorCodes.ArticleDraftNotFound, "Article draft does not exist.");
            if (snapshot!.TagId.HasValue) await resources.LockTagsAsync([snapshot.TagId.Value], cancellationToken, true);
            await LockDraftAsync(draftId, cancellationToken);
            var row = await drafts.GetAsync(draftId);
            CheckDraft(row, snapshot);
            var dto = await drafts.GetDetailAsync(row!);
            images = Images(dto.Content, dto.Cover);
            await drafts.DeleteAsync(draftId);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
        await CleanImagesAsync(images, cancellationToken);
    }
    private static void CheckArticle(ArticleDataModel? article, ArticleDataModel snapshot) =>
        Guard.Against(article is null || article.IsDeleted != 0 || article.TagId != snapshot.TagId || article.TagVersionId != snapshot.TagVersionId, "article_changed", "文章已改变，请刷新重试。");
    private static void CheckDraft(ArticleDraftDataModel? row, ArticleDraftDataModel snapshot) =>
        Guard.Against(row is null || row.TagId != snapshot.TagId || row.TagVersionId != snapshot.TagVersionId || row.ArticleId != snapshot.ArticleId, "draft_changed", "草稿已改变，请刷新重试。");
    private async Task LockDraftAsync(long id, CancellationToken ct) =>
        Guard.Against(!await drafts.LockAsync(id, ct), ErrorCodes.ArticleDraftNotFound, "Article draft does not exist.");
    private async Task LockArticleAsync(long id, CancellationToken ct) =>
        Guard.Against(!await articles.LockAsync(id, ct), ErrorCodes.ArticleNotFound, "Article does not exist.");
    private async Task CleanImagesAsync(IReadOnlyCollection<string> images, CancellationToken ct) {
        if (images.Count == 0) return;
        try {
            var removable = new List<string>();
            foreach (var image in images)
                if (!await drafts.IsImageUsedAsync(image)) removable.Add(image);
            await storage.DeleteManyAsync(removable, ct);
        } catch {
            // 图片清理失败不改变已经提交的保存、发布或删除结果。
        }
    }
    private static string Normalize(string? value) => value?.Trim() ?? "";
    private static long? ParseId(string? text) {
        if (string.IsNullOrWhiteSpace(text)) return null;
        Guard.Against(!long.TryParse(text, out var id) || id <= 0, "draft_id_invalid", "文章或草稿ID无效。");
        return id;
    }
    private static IReadOnlyCollection<string> Images(string markdown, string cover) => MarkdownImageRegex().Matches(markdown)
        .Select(x => x.Groups[1].Value).Append(cover).Where(x => !string.IsNullOrWhiteSpace(x)).Select(x => x.Trim()).Distinct(StringComparer.OrdinalIgnoreCase).ToArray();
    [GeneratedRegex("!\\[[^\\]]*\\]\\(([^)]+)\\)")]
    private static partial Regex MarkdownImageRegex();
}
