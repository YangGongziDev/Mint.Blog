namespace Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnPageList;

public sealed record AdminColumnPageItemDto(
	long Id,
	string Title,
	string Cover,
	string Summary,
	int Sort,
	int Weight,
	DateTimeOffset CreatedAt,
	bool IsTop,
	bool IsPublish,
	int ArticlesTotal);