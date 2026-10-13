using System.Text.Json.Serialization;

namespace Mint.Blog.Application.System.Auth.Login;

public sealed record LoginResult(
	[property: JsonPropertyName("token")] string AccessToken,
	string RefreshToken,
	DateTimeOffset ExpiresAt,
	DateTimeOffset RefreshTokenExpiresAt,
	string UserName,
	string DisplayName) {
	public int ExpiresIn => Math.Max(0, (int)(ExpiresAt - DateTimeOffset.UtcNow).TotalSeconds);
}
