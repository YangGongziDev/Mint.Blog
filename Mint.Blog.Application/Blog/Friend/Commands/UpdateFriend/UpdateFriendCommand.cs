namespace Mint.Blog.Application.Blog.Friend.Commands.UpdateFriend;

public sealed record UpdateFriendCommand(
	long FriendId,
	string Name,
	string Avatar,
	string Category,
	string Url,
	string Description,
	string? Email);