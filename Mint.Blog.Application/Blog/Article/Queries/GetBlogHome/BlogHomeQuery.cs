namespace Mint.Blog.Application.Blog.Article.Queries.GetBlogHome;

public sealed record BlogHomeQuery(
	int LatestArticleCount = 8,
	int HotArticleCount = 8,
	int TopArticleCount = 5);