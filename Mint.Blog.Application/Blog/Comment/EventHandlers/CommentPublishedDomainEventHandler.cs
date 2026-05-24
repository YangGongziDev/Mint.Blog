using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Comment.Notifications;
using Mint.Blog.Domain.Blog.Comment.Events;

namespace Mint.Blog.Application.Blog.Comment.EventHandlers;

public sealed class CommentPublishedDomainEventHandler(ICommentNotificationQueue commentNotificationQueue)
	: IDomainEventHandler<CommentPublishedDomainEvent> {
	public Task HandleAsync(CommentPublishedDomainEvent domainEvent, CancellationToken cancellationToken = default){
		return commentNotificationQueue.EnqueueAsync(
			new CommentNotificationJob(CommentNotificationKind.Published, domainEvent.CommentId),
			cancellationToken).AsTask();
	}
}
