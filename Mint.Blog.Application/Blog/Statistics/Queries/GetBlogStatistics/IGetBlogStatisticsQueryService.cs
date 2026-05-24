namespace Mint.Blog.Application.Blog.Statistics.Queries.GetBlogStatistics;

public interface IGetBlogStatisticsQueryService {
	Task<BlogStatisticsDto> GetAsync(CancellationToken cancellationToken = default);
}