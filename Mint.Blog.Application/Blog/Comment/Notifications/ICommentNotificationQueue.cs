namespace Mint.Blog.Application.Blog.Comment.Notifications;

public interface ICommentNotificationQueue {
	ValueTask EnqueueAsync(CommentNotificationJob job, CancellationToken cancellationToken = default);
}