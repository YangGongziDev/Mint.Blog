namespace Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

public sealed record PagedResult<T>(
	IReadOnlyCollection<T> Items,
	int PageNumber,
	int PageSize,
	int TotalCount);