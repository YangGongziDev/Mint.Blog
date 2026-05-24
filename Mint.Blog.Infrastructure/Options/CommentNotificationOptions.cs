namespace Mint.Blog.Infrastructure.Options;

public sealed class CommentNotificationOptions {
	public const string SectionName = "CommentNotification";

	public string Domain { get; set; } = string.Empty;
}