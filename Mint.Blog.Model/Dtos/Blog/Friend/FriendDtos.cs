namespace Mint.Blog.Model.Dtos.Blog.Friend;

public sealed record ApplyFriendCommand(string Name, string Avatar, string Category, string Url, string Description, string? Email, string? RssUrl = null);
public sealed record CreateAdminFriendCommand(string Name, string Avatar, string Category, string Url, string Description, string? Email, string? RssUrl = null);
public sealed record UpdateFriendCommand(long FriendId, string Name, string Avatar, string Category, string Url, string Description, string? Email, string? RssUrl = null);
public sealed record DeleteFriendCommand(long FriendId, long DeleteType);
public sealed record SetFriendTopCommand(long FriendId, bool IsTop);
public sealed record SetFriendStatusCommand(long FriendId, string Status);
public sealed record UpdateFriendSortCommand(long FriendId, int Sort);
public sealed record MoveFriendSortFirstCommand(long FriendId);
public sealed record MoveFriendSortLastCommand(long FriendId);
public sealed record GetAdminFriendPageListQuery(int PageNumber = 1, int PageSize = 10, string? Name = null, DateOnly? StartDate = null, DateOnly? EndDate = null, string? SortOrder = null);
public sealed record GetFriendListQuery(int PageNumber = 1, int PageSize = 10);
public sealed record GetFriendDetailQuery(long FriendId);
