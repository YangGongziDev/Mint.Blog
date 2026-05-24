namespace Mint.Blog.Application.System.User.Commands.UpdateSystemUserPassword;

public sealed record UpdateSystemUserPasswordCommand(string UserName, string Password);
