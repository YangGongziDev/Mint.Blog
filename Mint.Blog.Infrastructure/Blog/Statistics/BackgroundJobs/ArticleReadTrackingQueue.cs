using System.Threading.Channels;
using Mint.Blog.Application.Blog.Statistics.Commands.TrackArticleRead;

namespace Mint.Blog.Infrastructure.Blog.Statistics.BackgroundJobs;

public sealed class ArticleReadTrackingQueue : IArticleReadTrackingQueue {
	private readonly Channel<TrackArticleReadCommand> _channel = Channel.CreateUnbounded<TrackArticleReadCommand>();

	public ValueTask EnqueueAsync(TrackArticleReadCommand command, CancellationToken cancellationToken = default){
		return _channel.Writer.WriteAsync(command, cancellationToken);
	}

	public IAsyncEnumerable<TrackArticleReadCommand> DequeueAllAsync(CancellationToken cancellationToken){
		return _channel.Reader.ReadAllAsync(cancellationToken);
	}
}