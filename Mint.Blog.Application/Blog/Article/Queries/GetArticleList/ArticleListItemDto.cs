namespace Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

public sealed record ArticleListItemDto(
	long Id,
	string Title,
	string Summary,
	string Cover,
	long CategoryId,
	string CategoryName,
	IReadOnlyCollection<ArticleTagDto> Tags,
	bool IsTop,
	short Visibility,
	short IsDeleted,
	long ReadCount,
	DateTimeOffset CreatedAt) {
	public DateTimeOffset CreateTime => CreatedAt;
}