namespace Mint.Blog.Application.Blog.Article.Drafts;

public sealed record ArticleDraftListItemDto(
	string Id,
	string? ArticleId,
	string Title,
	string Summary,
	string Cover,
	long? CategoryId,
	string CategoryName,
	bool IsNewArticleDraft,
	DateTimeOffset CreatedAt,
	DateTimeOffset UpdatedAt);
