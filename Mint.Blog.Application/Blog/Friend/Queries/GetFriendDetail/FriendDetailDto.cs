namespace Mint.Blog.Application.Blog.Friend.Queries.GetFriendDetail;

public sealed record FriendDetailDto(
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
	DateTimeOffset UpdatedAt);