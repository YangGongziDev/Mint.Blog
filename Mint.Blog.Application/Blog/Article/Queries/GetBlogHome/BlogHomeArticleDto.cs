namespace Mint.Blog.Application.Blog.Article.Queries.GetBlogHome;

public sealed record BlogHomeArticleDto(
	long Id,
	string Title,
	string Summary,
	string Cover,
	long CategoryId,
	string CategoryName,
	IReadOnlyCollection<string> TagNames,
	bool IsTop,
	long ReadCount,
	DateTimeOffset CreatedAt);