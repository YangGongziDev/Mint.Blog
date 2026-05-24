namespace Mint.Blog.Application.System.User.Commands.UpdateUser;

public sealed record UpdateUserCommand(
    long UserId,
    string UserName,
    string DisplayName,
    int IsDeleted);
