namespace Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

public sealed record ArticleListQuery(
	int PageNumber,
	int PageSize,
	long? CategoryId = null,
	long? TagId = null,
	string? Title = null,
	DateOnly? StartDate = null,
	DateOnly? EndDate = null);