namespace Mint.Blog.Application.Blog.Friend.Queries.GetAdminFriendPageList;

public sealed record GetAdminFriendPageListQuery(
	int PageNumber = 1,
	int PageSize = 10,
	string? Name = null,
	DateOnly? StartDate = null,
	DateOnly? EndDate = null,
	string? SortOrder = null);