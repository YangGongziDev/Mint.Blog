namespace Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPvStatistics;

public sealed record AdminDashboardPvStatisticsDto(
	IReadOnlyCollection<string> PvDates,
	IReadOnlyCollection<long> PvCounts);