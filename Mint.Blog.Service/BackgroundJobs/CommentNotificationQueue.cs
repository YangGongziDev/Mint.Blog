using System.Threading.Channels;
using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.BackgroundJobs;

public sealed class CommentNotificationQueue : ICommentNotificationQueue {
    private readonly Channel<CommentNotificationJob> _channel = Channel.CreateUnbounded<CommentNotificationJob>();
    public ValueTask EnqueueAsync(CommentNotificationJob job, CancellationToken cancellationToken = default) => _channel.Writer.WriteAsync(job, cancellationToken);
    public IAsyncEnumerable<CommentNotificationJob> DequeueAllAsync(CancellationToken cancellationToken) => _channel.Reader.ReadAllAsync(cancellationToken);
}
