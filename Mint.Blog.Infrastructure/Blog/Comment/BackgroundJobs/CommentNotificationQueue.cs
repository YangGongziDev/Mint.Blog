using System.Threading.Channels;
using Mint.Blog.Application.Blog.Comment.Notifications;

namespace Mint.Blog.Infrastructure.Blog.Comment.BackgroundJobs;

public sealed class CommentNotificationQueue : ICommentNotificationQueue {
	private readonly Channel<CommentNotificationJob> _channel = Channel.CreateUnbounded<CommentNotificationJob>();

	public ValueTask EnqueueAsync(CommentNotificationJob job, CancellationToken cancellationToken = default){
		return _channel.Writer.WriteAsync(job, cancellationToken);
	}

	public IAsyncEnumerable<CommentNotificationJob> DequeueAllAsync(CancellationToken cancellationToken){
		return _channel.Reader.ReadAllAsync(cancellationToken);
	}
}