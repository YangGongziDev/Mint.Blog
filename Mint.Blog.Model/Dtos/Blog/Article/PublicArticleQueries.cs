namespace Mint.Blog.Model.Dtos.Blog.Article;

public sealed record GetArchivePageListQuery(int PageNumber = 1, int PageSize = 10);
public sealed record GetArchiveYearListQuery(int Year);
public sealed record BlogHomeQuery(int LatestArticleCount = 8, int HotArticleCount = 8, int TopArticleCount = 5);
public sealed record SurferArchivePageRequest(int Current = 1, int Size = 20, string? Year = null);
