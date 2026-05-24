using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Mint.Blog.Infrastructure.Blog.Statistics.Repositories;

namespace Mint.Blog.Infrastructure.Blog.Statistics.BackgroundJobs;

public sealed class ArticleReadTrackingBackgroundService(
	ArticleReadTrackingQueue queue,
	IServiceScopeFactory serviceScopeFactory,
	ILogger<ArticleReadTrackingBackgroundService> logger) : BackgroundService {
	protected override async Task ExecuteAsync(CancellationToken stoppingToken){
		await foreach (var command in queue.DequeueAllAsync(stoppingToken))
			try {
				using var scope = serviceScopeFactory.CreateScope();
				var statisticsCommandRepository =
					scope.ServiceProvider.GetRequiredService<StatisticsCommandRepository>();
				await statisticsCommandRepository.TrackArticleReadAsync(command.ArticleId, stoppingToken);
			} catch (Exception exception) {
				logger.LogError(exception, "Failed to process article read tracking. ArticleId={ArticleId}",
					command.ArticleId);
			}
	}
}