using Mint.Blog.Model.Vos.Blog.Statistics;

namespace Mint.Blog.Service.IService.Blog;

public interface IStatisticsService {
    Task TrackArticleReadAsync(long articleId, CancellationToken cancellationToken = default);
    Task EnsureTomorrowPvRecordAsync(CancellationToken cancellationToken = default);
    Task<BlogStatisticsDto> GetBlogAsync(CancellationToken cancellationToken = default);
    Task<AdminDashboardStatisticsDto> GetDashboardAsync(CancellationToken cancellationToken = default);
    Task<AdminDashboardPvStatisticsDto> GetPvAsync(CancellationToken cancellationToken = default);
    Task<AdminDashboardPublishArticleStatisticsDto> GetPublishAsync(CancellationToken cancellationToken = default);
}
