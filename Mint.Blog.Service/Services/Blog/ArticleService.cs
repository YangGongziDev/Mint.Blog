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

public sealed partial class ArticleService(IArticleRepository articles, IResourceRepository resources,
    ArticleTagVersionService tagVersions, IUnitOfWork unitOfWork, IArticleReadQueue reads,
    IArticleImageStorage storage, IImageRepository images) : IArticleService {
    public async Task<PagedResult<ArticleListItemDto>> GetAsync(ArticleListQuery query, CancellationToken cancellationToken = default) {
        cancellationToken.ThrowIfCancellationRequested();
        if (query.TagVersionId.HasValue) {
            Guard.Against(query.TagId is not > 0 || query.TagVersionId <= 0, "article_tag_version_invalid", "筛选版本必须指定标签及实际版本ID。");
            Guard.Against(!await articles.FilterVersionExistsAsync(query), "article_tag_version_invalid", "版本不存在、不可用或不属于该标签。");
        }
        return await articles.GetListAsync(query, cancellationToken);
    }
    public Task<PagedResult<SearchArticleItemDto>> GetAsync(SearchArticlesQuery query, CancellationToken cancellationToken = default) => articles.SearchAsync(query, cancellationToken);
    public async Task<ArticleDetailDto?> GetAsync(ArticleDetailQuery query, CancellationToken cancellationToken = default) {
        var article = await articles.GetByIdAsync(query.ArticleId, cancellationToken);
        if (article is null || (!query.ForAdmin && article.IsDeleted != 0)) return null;
        if (!query.ForAdmin) {
            if (!await articles.HasValidSelectionAsync(article.Id)) return null;
            if (query.ColumnId.HasValue) {
                if (!await articles.IsPublishedColumnAsync(query.ColumnId.Value)) return null;
                var catalogs = await articles.GetCatalogsAsync(query.ColumnId.Value);
                if (!catalogs.Any(x => x.Level == 2 && x.ArticleId == article.Id && catalogs.Any(p => p.Id == x.ParentId && p.Level == 1))) return null;
            } else if (article.Visibility != 1) return null;
            if (article.Visibility is not (1 or 2)) return null;
        }
        var selection = await articles.GetSelectionAsync(article.Id, cancellationToken);
        if (!query.ForAdmin) {
            await reads.EnqueueAsync(article.Id, cancellationToken);
            article.ReadCount += 1;
        }
        return new(article.Id, article.Title, article.Summary, article.Content, article.Cover,
            selection.CategoryId, selection.CategoryName, article.TagId, article.TagVersionId,
            selection.TagName, selection.TagVersionName, selection.IsGeneral,
            article.IsTop, article.Visibility, article.ReadCount, article.CreatedAt, article.UpdatedAt);
    }
    public async Task<long> CreateAsync(CreateArticleCommand command, CancellationToken cancellationToken = default) {
        var title = command.Title?.Trim() ?? "";
        var summary = command.Summary?.Trim() ?? "";
        var content = command.Content?.Trim() ?? "";
        var cover = command.Cover?.Trim() ?? "";
        ValidateContent(title, summary, content, cover, command.Visibility);
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            await tagVersions.ValidateAsync(command.TagId, command.TagVersionId, false, cancellationToken);
            var article = CreateArticle(title, summary, content, cover, command.TagId, command.TagVersionId, command.Visibility);
            var id = await articles.AddAsync(article, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
            return id;
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
    public async Task UpdateAsync(UpdateArticleCommand command, CancellationToken cancellationToken = default) {
        var title = command.Title?.Trim() ?? "";
        var summary = command.Summary?.Trim() ?? "";
        var content = command.Content?.Trim() ?? "";
        var cover = command.Cover?.Trim() ?? "";
        ValidateContent(title, summary, content, cover, command.Visibility);
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var snapshot = await RequiredArticleAsync(command.ArticleId, cancellationToken);
            await resources.LockTagsAsync([snapshot.TagId, command.TagId], cancellationToken, true);
            await tagVersions.ValidateAsync(command.TagId, command.TagVersionId, false, cancellationToken);
            await articles.LockAsync(command.ArticleId, cancellationToken);
            var article = await RequiredArticleAsync(command.ArticleId, cancellationToken);
            Guard.Against(article.IsDeleted != 0, ErrorCodes.ArticleNotFound, "文章已删除，请先恢复。");
            CheckSnapshot(article, snapshot);
            UpdateArticle(article, title, summary, content, cover, command.TagId, command.TagVersionId, command.Visibility);
            await articles.UpdateAsync(article, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
    public async Task PatchAsync(PatchArticleCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(!command.HasIsTop && !command.HasVisibility, ErrorCodes.ArticleContentInvalid, "At least one article field must be provided.");
        Guard.Against(command.HasIsTop && command.IsTop is null, ErrorCodes.ArticleContentInvalid, "Article isTop cannot be null.");
        Guard.Against(command.HasVisibility && (command.Visibility is null || command.Visibility is not (1 or 2)), ErrorCodes.ArticleContentInvalid, "Article visibility must be 1 or 2.");
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var snapshot = await RequiredArticleAsync(command.ArticleId, cancellationToken);
            await resources.LockTagsAsync([snapshot.TagId], cancellationToken);
            await tagVersions.ValidateAsync(snapshot.TagId, snapshot.TagVersionId, false, cancellationToken);
            await articles.LockAsync(command.ArticleId, cancellationToken);
            var article = await RequiredArticleAsync(command.ArticleId, cancellationToken);
            Guard.Against(article.IsDeleted != 0, ErrorCodes.ArticleNotFound, "文章已删除，请先恢复。");
            CheckSnapshot(article, snapshot);
            await articles.PatchStateAsync(command.ArticleId, command.HasIsTop ? command.IsTop : null, command.HasVisibility ? command.Visibility : null, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
    public async Task DeleteAsync(DeleteArticleCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.DeleteType is not (1 or 2 or 3), ErrorCodes.DeleteTypeInvalid, "删除类型应为1（软删除）、2（永久删除）或3（恢复）。");
        IReadOnlyCollection<string> articleImages = [];
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var snapshot = await RequiredArticleAsync(command.ArticleId, cancellationToken);
            await resources.LockTagsAsync([snapshot.TagId], cancellationToken, true);
            if (command.DeleteType == 3) await tagVersions.ValidateAsync(snapshot.TagId, snapshot.TagVersionId, false, cancellationToken);
            await articles.LockAsync(command.ArticleId, cancellationToken);
            var article = await RequiredArticleAsync(command.ArticleId, cancellationToken);
            CheckSnapshot(article, snapshot);
            if (command.DeleteType == 2) articleImages = ExtractImages(article.Content).Append(article.Cover)
                .Where(image => !string.IsNullOrWhiteSpace(image)).Select(image => image.Trim()).Distinct(StringComparer.OrdinalIgnoreCase).ToArray();
            await articles.DeleteAsync(command.ArticleId, command.DeleteType, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
        if (command.DeleteType == 2 && articleImages.Count > 0) {
            try {
                var removable = new List<string>();
                foreach (var image in articleImages)
                    if (!await images.IsUsedAsync(image, cancellationToken)) removable.Add(image);
                await storage.DeleteManyAsync(removable, cancellationToken);
            } catch {
                // 图片清理失败不应影响已提交的文章删除结果。
            }
        }
    }
    private async Task<ArticleDataModel> RequiredArticleAsync(long id, CancellationToken ct) =>
        await articles.GetByIdAsync(id, ct) ?? throw new BusinessException(ErrorCodes.ArticleNotFound, "Article does not exist.");
    private static void CheckSnapshot(ArticleDataModel article, ArticleDataModel snapshot) =>
        Guard.Against(article.TagId != snapshot.TagId || article.TagVersionId != snapshot.TagVersionId, "article_changed", "文章已被并发修改，请刷新重试。");
    private static void ValidateContent(string title, string summary, string content, string cover, short visibility) {
        Guard.Against(title.Length == 0, ErrorCodes.ArticleTitleInvalid, "Article title is required.");
        Guard.Against(summary.Length is 0 or > 160, ErrorCodes.ArticleSummaryInvalid, "摘要应为1至160字符。");
        Guard.Against(content.Length == 0, ErrorCodes.ArticleContentInvalid, "Article content is required.");
        Guard.Against(cover.Length == 0, ErrorCodes.ArticleCoverInvalid, "Article cover is required.");
        Guard.Against(visibility is not (1 or 2), ErrorCodes.ArticleContentInvalid, "Article visibility must be 1 or 2.");
    }
    internal static ArticleDataModel CreateArticle(string title, string summary, string content, string cover, long tagId, long versionId, short visibility) {
        var article = new ArticleDataModel { CreatedAt = DateTimeOffset.UtcNow, UpdatedAt = DateTimeOffset.UtcNow };
        SetContent(article, title, summary, content, cover, tagId, versionId, visibility);
        return article;
    }
    internal static void UpdateArticle(ArticleDataModel article, string title, string summary, string content, string cover, long tagId, long versionId, short visibility) {
        SetContent(article, title, summary, content, cover, tagId, versionId, visibility);
        article.UpdatedAt = DateTimeOffset.UtcNow;
    }
    private static void SetContent(ArticleDataModel article, string title, string summary, string content, string cover, long tagId, long versionId, short visibility) {
        if (tagId <= 0 || versionId <= 0) throw new ArgumentException("必须选择实际标签和版本。");
        if (visibility is not (1 or 2)) throw new ArgumentException("文章可见性必须为1或2。");
        if (string.IsNullOrWhiteSpace(title)) throw new ArgumentException("Article title is required.", "value");
        if (string.IsNullOrWhiteSpace(summary)) throw new ArgumentException("Article summary is required.", "value");
        if (string.IsNullOrWhiteSpace(content)) throw new ArgumentException("Article content is required.", "value");
        article.Title = title.Trim(); article.Summary = summary.Trim(); article.Content = content.Trim(); article.Cover = cover.Trim();
        article.TagId = tagId; article.TagVersionId = versionId; article.Visibility = visibility;
    }
    private static IEnumerable<string> ExtractImages(string markdown) => string.IsNullOrWhiteSpace(markdown) ? [] :
        MarkdownImageRegex().Matches(markdown).Select(match => match.Groups[1].Value).Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase);
    [GeneratedRegex("!\\[[^\\]]*\\]\\(([^)]+)\\)")]
    private static partial Regex MarkdownImageRegex();
}
