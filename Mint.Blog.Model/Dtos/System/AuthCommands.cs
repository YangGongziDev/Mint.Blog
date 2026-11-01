namespace Mint.Blog.Model.Dtos.System;
public sealed record LoginCommand(string UserName, string Password);
public sealed record RefreshTokenCommand(string RefreshToken);
public sealed record LogoutCommand(string RefreshToken);
public sealed record ChangeOwnPasswordCommand(string OldPassword, string NewPassword);
