namespace Mint.Blog.Application.Blog.Comment.Notifications;

public interface ICommentNotificationService {
	Task NotifyCommentPublishedAsync(long commentId, CancellationToken cancellationToken = default);
	Task NotifyCommentExaminedAsync(long commentId, CancellationToken cancellationToken = default);
}
