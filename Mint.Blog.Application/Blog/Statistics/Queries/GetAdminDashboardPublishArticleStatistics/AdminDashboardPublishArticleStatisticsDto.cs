namespace Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPublishArticleStatistics;

public sealed record AdminDashboardPublishArticleStatisticsDto(
	IReadOnlyCollection<string> Dates,
	IReadOnlyCollection<long> Counts);