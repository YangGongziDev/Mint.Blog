namespace Mint.Blog.Application.Blog.Friend.Commands.CreateAdminFriend;

public sealed record CreateAdminFriendCommand(
	string Name,
	string Avatar,
	string Category,
	string Url,
	string Description,
	string? Email);