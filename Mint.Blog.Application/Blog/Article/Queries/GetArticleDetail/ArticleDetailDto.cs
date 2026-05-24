namespace Mint.Blog.Application.Blog.Article.Queries.GetArticleDetail;

public sealed record ArticleDetailDto(
	long Id,
	string Title,
	string Summary,
	string Content,
	string Cover,
	long CategoryId,
	string CategoryName,
	IReadOnlyCollection<ArticleTagDto> Tags,
	bool IsTop,
	long ReadCount,
	DateTimeOffset CreatedAt,
	DateTimeOffset UpdatedAt);