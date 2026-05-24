namespace Mint.Blog.Infrastructure.Options;

public sealed class JwtOptions {
	public const string SectionName = "Jwt";

	public string Issuer { get; set; } = string.Empty;
	public string Audience { get; set; } = string.Empty;
	public string SecurityKey { get; set; } = string.Empty;
	public int AccessTokenExpireMinutes { get; set; } = 120;
}