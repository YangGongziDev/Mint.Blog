namespace Mint.Blog.Application.Blog.Comment.Notifications;

public sealed record CommentNotificationJob(CommentNotificationKind Kind, long CommentId);

public enum CommentNotificationKind {
	Published = 1,
	Examined = 2
}
