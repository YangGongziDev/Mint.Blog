namespace Mint.Blog.Application.Blog.Article.Queries.SearchArticles;

public sealed record SearchArticlesQuery(
	string Keyword,
	int PageNumber = 1,
	int PageSize = 10);