namespace Mint.Blog.Infrastructure.Options;

public sealed class SmtpOptions {
	public const string SectionName = "Smtp";

	public string Host { get; set; } = string.Empty;
	public int Port { get; set; } = 465;
	public string UserName { get; set; } = string.Empty;
	public string Password { get; set; } = string.Empty;
	public string From { get; set; } = string.Empty;
	public bool EnableSsl { get; set; } = true;
}