namespace Mint.Blog.Application.System.Auth.Login;

public sealed record LoginCommand(string UserName, string Password);