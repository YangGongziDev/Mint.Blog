namespace Mint.Blog.Infrastructure.Options;

public sealed class AdminAccountOptions {
	public const string SectionName = "AdminAccount";

	public string UserName { get; set; } = string.Empty;
	public string Password { get; set; } = string.Empty;
}