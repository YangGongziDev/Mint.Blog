using System.Threading.Channels;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.BackgroundJobs;

public sealed class ArticleReadTrackingQueue : IArticleReadQueue {
	private readonly Channel<long> _channel = Channel.CreateUnbounded<long>();

	public ValueTask EnqueueAsync(long articleId, CancellationToken cancellationToken = default) =>
		_channel.Writer.WriteAsync(articleId, cancellationToken);

	public IAsyncEnumerable<long> DequeueAllAsync(CancellationToken cancellationToken) =>
		_channel.Reader.ReadAllAsync(cancellationToken);
}
