namespace Mint.Blog.Application.Blog.Statistics.Queries.GetBlogStatistics;

public sealed record BlogStatisticsDto(
	long ArticleTotalCount,
	long CategoryTotalCount,
	long TagTotalCount,
	long ColumnTotalCount,
	long PvTotalCount);