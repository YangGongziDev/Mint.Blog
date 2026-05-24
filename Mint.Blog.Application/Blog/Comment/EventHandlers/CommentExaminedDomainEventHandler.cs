using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Comment.Notifications;
using Mint.Blog.Domain.Blog.Comment.Events;

namespace Mint.Blog.Application.Blog.Comment.EventHandlers;

public sealed class CommentExaminedDomainEventHandler(ICommentNotificationQueue commentNotificationQueue)
	: IDomainEventHandler<CommentExaminedDomainEvent> {
	public Task HandleAsync(CommentExaminedDomainEvent domainEvent, CancellationToken cancellationToken = default){
		return commentNotificationQueue.EnqueueAsync(
			new CommentNotificationJob(CommentNotificationKind.Examined, domainEvent.CommentId),
			cancellationToken).AsTask();
	}
}
