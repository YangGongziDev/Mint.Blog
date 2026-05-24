namespace Mint.Blog.Application.Blog.Friend.Commands.SetFriendTop;

public sealed record SetFriendTopCommand(long FriendId, bool IsTop);