namespace Mint.Blog.Application.Blog.Friend.Queries.GetFriendList;

public sealed record GetFriendListQuery(
	int PageNumber = 1,
	int PageSize = 10);