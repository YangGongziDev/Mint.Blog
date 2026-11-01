namespace Mint.Blog.Model.Vos.Blog.Article;

public sealed record ArchiveArticleDto(
    long Id, string Cover, string Title, DateOnly CreatedDate,
    long TagId, long TagVersionId, long CategoryId, string CategoryName, string TagName,
    string TagVersionName, bool IsGeneral);
public sealed record ArchiveMonthGroupDto(string Month, IReadOnlyCollection<ArchiveArticleDto> Articles);
public sealed record ArchiveYearDto(int Year, int ArticlesTotal);
public sealed record BlogHomeArticleDto(
    long Id, string Title, string Summary, string Cover,
    long CategoryId, string CategoryName, long TagId, long TagVersionId,
    string TagName, string TagVersionName, bool IsGeneral,
    bool IsTop, long ReadCount, DateTimeOffset CreatedAt);
public sealed record BlogHomeDto(
    IReadOnlyCollection<BlogHomeArticleDto> LatestArticles,
    IReadOnlyCollection<BlogHomeArticleDto> HotArticles,
    IReadOnlyCollection<BlogHomeArticleDto> TopArticles);
public sealed record RssArticleDto(
    long Id, string Title, string Summary, string Content, DateTimeOffset CreatedAt, DateTimeOffset UpdatedAt);
public sealed record SurferArchivePageResponse(bool Success, IReadOnlyCollection<SurferArchiveMonth> Data, int Current, int Size, int Total, int Pages);
public sealed record SurferArchiveYearsResponse(bool Success, IReadOnlyCollection<ArchiveYearDto> Data);
public sealed record SurferArchiveMonth(string Month, IReadOnlyCollection<SurferArchiveArticle> Articles);
public sealed record SurferArchiveArticle(long Id, string Title, string Cover, string CreateDate,
    long TagId, long TagVersionId, long CategoryId, string CategoryName, string TagName, string TagVersionName, bool IsGeneral);
