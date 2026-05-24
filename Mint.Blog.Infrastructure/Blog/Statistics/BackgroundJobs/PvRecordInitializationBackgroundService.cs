using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Mint.Blog.Infrastructure.Blog.Statistics.Repositories;

namespace Mint.Blog.Infrastructure.Blog.Statistics.BackgroundJobs;

public sealed class PvRecordInitializationBackgroundService(
	IServiceScopeFactory serviceScopeFactory,
	ILogger<PvRecordInitializationBackgroundService> logger) : BackgroundService {
	protected override async Task ExecuteAsync(CancellationToken stoppingToken){
		await EnsureTomorrowRecordAsync(stoppingToken);

		using var timer = new PeriodicTimer(TimeSpan.FromHours(1));
		while (await timer.WaitForNextTickAsync(stoppingToken)) await EnsureTomorrowRecordAsync(stoppingToken);
	}

	private async Task EnsureTomorrowRecordAsync(CancellationToken cancellationToken){
		try {
			using var scope = serviceScopeFactory.CreateScope();
			var repository = scope.ServiceProvider.GetRequiredService<StatisticsCommandRepository>();
			await repository.EnsureTomorrowPvRecordAsync(cancellationToken);
		} catch (Exception exception) {
			logger.LogError(exception, "Failed to ensure tomorrow PV record.");
		}
	}
}