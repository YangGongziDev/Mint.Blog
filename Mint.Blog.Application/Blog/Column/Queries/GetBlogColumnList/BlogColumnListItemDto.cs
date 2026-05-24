namespace Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnList;

public sealed record BlogColumnListItemDto(
	long Id,
	string Cover,
	string Title,
	int ArticlesTotal,
	string Summary,
	int Sort,
	int Weight,
	bool IsTop,
	long? FirstArticleId);