namespace Mint.Blog.Model.Vos.Blog.Column;

public sealed record AdminColumnCatalogItemDto(long Id, long ArticleId, string Title, int Sort, int Level,
    bool IsDeleted, bool Editing, IReadOnlyCollection<AdminColumnCatalogItemDto> Children);
public sealed record AdminColumnPageItemDto(long Id, string Title, string Cover, string Summary, int Sort,
    int Weight, DateTimeOffset CreatedAt, bool IsTop, bool IsPublish, int ArticlesTotal, short IsDeleted);
public sealed record BlogColumnArticleLinkDto(long ArticleId, string ArticleTitle);
public sealed record BlogColumnArticlePreNextDto(BlogColumnArticleLinkDto? PreArticle, BlogColumnArticleLinkDto? NextArticle);
public sealed record BlogColumnCatalogItemDto(long Id, long ArticleId, string Title, int Level,
    IReadOnlyCollection<BlogColumnCatalogItemDto> Children);
public sealed record BlogColumnListItemDto(long Id, string Cover, string Title, int ArticlesTotal, string Summary,
    int Sort, int Weight, bool IsTop, long? FirstArticleId);
