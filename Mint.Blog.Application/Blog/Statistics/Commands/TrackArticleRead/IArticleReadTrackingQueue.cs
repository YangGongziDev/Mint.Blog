namespace Mint.Blog.Application.Blog.Statistics.Commands.TrackArticleRead;

public interface IArticleReadTrackingQueue {
	ValueTask EnqueueAsync(TrackArticleReadCommand command, CancellationToken cancellationToken = default);
	IAsyncEnumerable<TrackArticleReadCommand> DequeueAllAsync(CancellationToken cancellationToken);
}