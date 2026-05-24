namespace Mint.Blog.Application.Blog.Article.Queries.SearchArticles;

public sealed record SearchArticleItemDto(
	long Id,
	string Title,
	string HighlightedTitle,
	string Summary,
	string Cover,
	DateTimeOffset CreatedAt);