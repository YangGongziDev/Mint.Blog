using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.BackgroundJobs;

public sealed class CommentNotificationBackgroundService(CommentNotificationQueue queue, IServiceScopeFactory serviceScopeFactory, ILogger<CommentNotificationBackgroundService> logger) : BackgroundService {
    protected override async Task ExecuteAsync(CancellationToken stoppingToken) {
        await foreach (var job in queue.DequeueAllAsync(stoppingToken)) {
            try {
                using var scope = serviceScopeFactory.CreateScope();
                var service = scope.ServiceProvider.GetRequiredService<ICommentNotificationService>();
                switch (job.Kind) {
                    case CommentNotificationKind.Published: await service.NotifyCommentPublishedAsync(job.CommentId, stoppingToken); break;
                    case CommentNotificationKind.Examined: await service.NotifyCommentExaminedAsync(job.CommentId, stoppingToken); break;
                }
            } catch (Exception exception) {
                logger.LogError(exception, "Failed to process comment notification background job. Kind={Kind}, CommentId={CommentId}", job.Kind, job.CommentId);
            }
        }
    }
}
