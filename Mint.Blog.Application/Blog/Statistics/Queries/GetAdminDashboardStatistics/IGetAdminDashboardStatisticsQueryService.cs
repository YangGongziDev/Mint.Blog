namespace Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardStatistics;

public interface IGetAdminDashboardStatisticsQueryService {
	Task<AdminDashboardStatisticsDto> GetAsync(CancellationToken cancellationToken = default);
}