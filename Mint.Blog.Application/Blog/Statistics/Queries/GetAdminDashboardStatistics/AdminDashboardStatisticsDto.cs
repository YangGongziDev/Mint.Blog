namespace Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardStatistics;

public sealed record AdminDashboardStatisticsDto(
	long ArticleTotalCount,
	long CategoryTotalCount,
	long TagTotalCount,
	long ColumnTotalCount,
	long PvTotalCount);