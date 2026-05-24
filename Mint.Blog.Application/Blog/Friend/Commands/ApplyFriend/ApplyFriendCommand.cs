namespace Mint.Blog.Application.Blog.Friend.Commands.ApplyFriend;

public sealed record ApplyFriendCommand(
	string Name,
	string Avatar,
	string Category,
	string Url,
	string Description,
	string? Email);