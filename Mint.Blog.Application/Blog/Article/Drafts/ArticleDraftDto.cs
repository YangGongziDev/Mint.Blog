namespace Mint.Blog.Application.Blog.Article.Drafts;

public sealed record ArticleDraftDto(
	string Id,
	long? ArticleId,
	string Title,
	string Summary,
	string Content,
	string Cover,
	long? CategoryId,
	IReadOnlyCollection<long> TagIds,
	DateTimeOffset CreatedAt,
	DateTimeOffset UpdatedAt);
