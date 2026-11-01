using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.BackgroundJobs;

public sealed class ArticleReadTrackingBackgroundService(
	ArticleReadTrackingQueue queue,
	IServiceScopeFactory serviceScopeFactory,
	ILogger<ArticleReadTrackingBackgroundService> logger) : BackgroundService {
	protected override async Task ExecuteAsync(CancellationToken stoppingToken){
		await foreach (var articleId in queue.DequeueAllAsync(stoppingToken))
			try {
				using var scope = serviceScopeFactory.CreateScope();
				var service = scope.ServiceProvider.GetRequiredService<IStatisticsService>();
				await service.TrackArticleReadAsync(articleId, stoppingToken);
			} catch (Exception exception) {
				logger.LogError(exception, "Failed to process article read tracking. ArticleId={ArticleId}", articleId);
			}
	}
}
