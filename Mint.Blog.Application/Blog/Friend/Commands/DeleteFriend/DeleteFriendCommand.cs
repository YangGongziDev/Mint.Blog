namespace Mint.Blog.Application.Blog.Friend.Commands.DeleteFriend;

public sealed record DeleteFriendCommand(long FriendId, long DeleteType);