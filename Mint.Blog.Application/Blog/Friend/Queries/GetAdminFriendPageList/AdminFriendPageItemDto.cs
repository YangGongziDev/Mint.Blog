namespace Mint.Blog.Application.Blog.Friend.Queries.GetAdminFriendPageList;

public sealed record AdminFriendPageItemDto(
	long Id,
	string Name,
	string Description,
	string Url,
	string Avatar,
	string Status,
	DateTimeOffset CreatedAt,
	string Category,
	bool IsTop,
	string Email,
	int Sort,
	bool IsDeleted,
	DateTimeOffset UpdatedAt);