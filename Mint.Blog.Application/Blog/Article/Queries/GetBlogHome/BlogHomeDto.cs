namespace Mint.Blog.Application.Blog.Article.Queries.GetBlogHome;

public sealed record BlogHomeDto(
	IReadOnlyCollection<BlogHomeArticleDto> LatestArticles,
	IReadOnlyCollection<BlogHomeArticleDto> HotArticles,
	IReadOnlyCollection<BlogHomeArticleDto> TopArticles);