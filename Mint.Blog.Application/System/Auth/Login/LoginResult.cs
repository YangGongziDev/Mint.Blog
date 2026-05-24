namespace Mint.Blog.Application.System.Auth.Login;

public sealed record LoginResult(
	string AccessToken,
	string RefreshToken,
	DateTimeOffset ExpiresAt,
	DateTimeOffset RefreshTokenExpiresAt,
	string UserName,
	string DisplayName);
