namespace Mint.Blog.Application.System.Role.Commands.UpdateUserRole;

public sealed record UpdateUserRoleCommand(
    long Id,
    string UserName,
    string Role);
