namespace Mint.Blog.Application.Blog.Friend.Commands.SetFriendStatus;

public sealed record SetFriendStatusCommand(long FriendId, string Status);