namespace Mint.Blog.Model.Vos.Blog.Article;

public sealed record ArticleListItemDto(long Id, string Title, string Summary, string Cover,
    long CategoryId, string CategoryName, long TagId, long TagVersionId, string TagName, string TagVersionName,
    bool IsGeneral, bool IsTop, short Visibility, short IsDeleted, long ReadCount, DateTimeOffset CreatedAt) {
    public DateTimeOffset CreateTime => CreatedAt;
}
public sealed record ArticleDetailDto(long Id, string Title, string Summary, string Content, string Cover,
    long CategoryId, string CategoryName, long TagId, long TagVersionId, string TagName, string TagVersionName,
    bool IsGeneral, bool IsTop, short Visibility, long ReadCount, DateTimeOffset CreatedAt, DateTimeOffset UpdatedAt);
public sealed record SearchArticleItemDto(long Id, string Title, string HighlightedTitle, string Summary, string Cover,
    DateTimeOffset CreatedAt, long TagId, long TagVersionId, long CategoryId, string CategoryName,
    string TagName, string TagVersionName, bool IsGeneral);
public sealed record ArticleDraftDto(string Id, long? ArticleId, string Title, string Summary, string Content, string Cover,
    long? CategoryId, string CategoryName, long? TagId, long? TagVersionId, string TagName, string TagVersionName,
    bool IsGeneral, short Visibility, DateTimeOffset CreatedAt, DateTimeOffset UpdatedAt);
public sealed record ArticleDraftListItemDto(string Id, string? ArticleId, string Title, string Summary, string Cover,
    long? CategoryId, string CategoryName, long? TagId, long? TagVersionId, string TagName, string TagVersionName,
    bool IsGeneral, bool IsNewArticleDraft, DateTimeOffset CreatedAt, DateTimeOffset UpdatedAt);
public sealed record SurferArticlePageResponse(bool Success, IReadOnlyCollection<SurferArticleItem> Data, int Current, int Size, int Total, int Pages);
public sealed record SurferArticleDetailResponse(bool Success, SurferArticleDetail? Data, string? ErrorCode = null, string? Message = null);
public sealed record SurferArticleItem(string Id, string Title, string Summary, string Cover, string CreateDate, bool IsTop,
    long ReadNum, long CategoryId, string CategoryName, long TagId, long TagVersionId, string TagName, string TagVersionName, bool IsGeneral);
public sealed record SurferArticleDetail(string Id, string Title, string Summary, string Content, string Cover,
    long TagId, long TagVersionId, string TagName, string TagVersionName, bool IsGeneral, int TotalWords, string ReadTime,
    string CreateTime, string UpdateTime, long CategoryId, string CategoryName, long ReadNum,
    SurferAdjacentArticle? PreArticle, SurferAdjacentArticle? NextArticle);
public sealed record SurferAdjacentArticle(long ArticleId, string ArticleTitle);

public static class ArticleResponseMapping {
    public static ArticleDraftListItemDto ToDraftListItem(Entitys.Blog.Article.ArticleDraftDataModel row, DraftSelection s) => new(
        row.Id.ToString(), row.ArticleId?.ToString(), string.IsNullOrWhiteSpace(row.Title) ? "未命名草稿" : row.Title,
        row.Summary, row.Cover, s.CategoryId, s.CategoryName, row.TagId, row.TagVersionId, s.TagName,
        s.TagVersionName, s.IsGeneral, !row.ArticleId.HasValue, row.CreatedAt, row.UpdatedAt);
    public static ArticleDraftDto ToDraftDetail(Entitys.Blog.Article.ArticleDraftDataModel row, string content, DraftSelection s) => new(
        row.Id.ToString(), row.ArticleId, row.Title, row.Summary, content, row.Cover, s.CategoryId, s.CategoryName,
        row.TagId, row.TagVersionId, s.TagName, s.TagVersionName, s.IsGeneral, row.Visibility, row.CreatedAt, row.UpdatedAt);
    public static SurferArticleItem ToSurferArticle(ArticleListItemDto item) => new(
        item.Id.ToString(), item.Title, item.Summary, item.Cover, item.CreatedAt.ToString("O"), item.IsTop, item.ReadCount,
        item.CategoryId, item.CategoryName, item.TagId, item.TagVersionId, item.TagName, item.TagVersionName, item.IsGeneral);
    public static SurferArticleDetail ToSurferArticleDetail(ArticleDetailDto item) {
        var plainTextLength = item.Content.Length;
        var readMinutes = Math.Max(1, (int)Math.Ceiling(plainTextLength / 500.0));
        return new(item.Id.ToString(), item.Title, item.Summary, item.Content, item.Cover,
            item.TagId, item.TagVersionId, item.TagName, item.TagVersionName, item.IsGeneral,
            plainTextLength, $"{readMinutes} 分钟", item.CreatedAt.ToString("O"), item.UpdatedAt.ToString("O"),
            item.CategoryId, item.CategoryName, item.ReadCount, null, null);
    }
}
public sealed class ArticleSelection {
    public long Id { get; set; }
    public long TagId { get; set; }
    public long CategoryId { get; set; }
    public string CategoryName { get; set; } = "";
    public string TagName { get; set; } = "";
    public string TagVersionName { get; set; } = "";
    public bool IsGeneral { get; set; }
}
public sealed class DraftSelection {
    public long? CategoryId { get; set; }
    public string CategoryName { get; set; } = "";
    public string TagName { get; set; } = "";
    public string TagVersionName { get; set; } = "";
    public bool IsGeneral { get; set; }
}
