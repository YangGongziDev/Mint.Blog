namespace Mint.Blog.Application.System.User.Commands.DeleteUser;

public sealed record DeleteUserCommand(long UserId, long DeleteType);