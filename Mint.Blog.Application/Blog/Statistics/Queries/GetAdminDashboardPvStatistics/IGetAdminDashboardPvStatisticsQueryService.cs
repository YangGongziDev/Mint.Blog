namespace Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPvStatistics;

public interface IGetAdminDashboardPvStatisticsQueryService {
	Task<AdminDashboardPvStatisticsDto> GetAsync(CancellationToken cancellationToken = default);
}