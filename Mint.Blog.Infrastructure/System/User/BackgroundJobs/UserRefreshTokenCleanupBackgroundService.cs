using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Mint.Blog.Domain.System.User.Repositories;

namespace Mint.Blog.Infrastructure.System.User.BackgroundJobs;

public sealed class UserRefreshTokenCleanupBackgroundService(
	IServiceScopeFactory scopeFactory,
	ILogger<UserRefreshTokenCleanupBackgroundService> logger) : BackgroundService {
	private static readonly TimeSpan CleanupInterval = TimeSpan.FromDays(1);
	private static readonly TimeSpan InvalidTokenRetention = TimeSpan.FromDays(7);

	protected override async Task ExecuteAsync(CancellationToken stoppingToken){
		await CleanupAsync(stoppingToken);

		using var timer = new PeriodicTimer(CleanupInterval);
		while (await timer.WaitForNextTickAsync(stoppingToken)) {
			await CleanupAsync(stoppingToken);
		}
	}

	private async Task CleanupAsync(CancellationToken cancellationToken){
		try {
			await using var scope = scopeFactory.CreateAsyncScope();
			var repository = scope.ServiceProvider.GetRequiredService<IUserRefreshTokenRepository>();
			var retentionBoundary = DateTimeOffset.UtcNow.Subtract(InvalidTokenRetention);
			var deletedCount = await repository.DeleteInvalidTokensCreatedBeforeAsync(retentionBoundary, cancellationToken);
			if (deletedCount > 0) {
				logger.LogInformation("Cleaned up {DeletedCount} invalid user refresh tokens.", deletedCount);
			}
		}
		catch (OperationCanceledException) when (cancellationToken.IsCancellationRequested) {
		}
		catch (Exception exception) {
			logger.LogWarning(exception, "Failed to cleanup invalid user refresh tokens.");
		}
	}
}
