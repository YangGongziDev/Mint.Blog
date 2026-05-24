using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPublishArticleStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPvStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetBlogStatistics;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Category.Persistence;
using Mint.Blog.Infrastructure.Blog.Tag.Persistence;
using Mint.Blog.Infrastructure.Blog.Column.Persistence;
using Mint.Blog.Infrastructure.Blog.Statistics.Persistence;

namespace Mint.Blog.Infrastructure.Blog.Statistics.Repositories;

public sealed class StatisticsQueryRepository(ISqlSugarDbContext dbContext)
	: IGetBlogStatisticsQueryService,
		IGetAdminDashboardStatisticsQueryService,
		IGetAdminDashboardPvStatisticsQueryService,
		IGetAdminDashboardPublishArticleStatisticsQueryService {
	async Task<AdminDashboardPublishArticleStatisticsDto> IGetAdminDashboardPublishArticleStatisticsQueryService.
		GetAsync(CancellationToken cancellationToken){
		var endDate = DateOnly.FromDateTime(DateTime.UtcNow.Date);
		var startDate = endDate.AddYears(-1);
		var startTime = startDate.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
		var endExclusive = endDate.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);

		var articles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.CreatedAt >= startTime && x.CreatedAt < endExclusive)
			.Select(x => new { x.CreatedAt })
			.ToListAsync();

		var countsByDate = articles
			.GroupBy(x => DateOnly.FromDateTime(x.CreatedAt.UtcDateTime.Date))
			.ToDictionary(group => group.Key, group => (long)group.Count());

		var dates = new List<string>();
		var counts = new List<long>();

		for (var date = startDate; date <= endDate; date = date.AddDays(1)) {
			dates.Add(date.ToString("yyyy-MM-dd"));
			counts.Add(countsByDate.GetValueOrDefault(date, 0));
		}

		return new AdminDashboardPublishArticleStatisticsDto(dates, counts);
	}

	async Task<AdminDashboardPvStatisticsDto> IGetAdminDashboardPvStatisticsQueryService.GetAsync(
		CancellationToken cancellationToken){
		var endDate = DateOnly.FromDateTime(DateTime.UtcNow.Date);
		var startDate = endDate.AddDays(-6);

		var records = await dbContext.Client.Queryable<StatisticsArticlePvDataModel>()
			.Where(x => x.PvDate >= startDate && x.PvDate <= endDate)
			.OrderBy(x => x.PvDate)
			.ToListAsync();

		var pvMap = records.ToDictionary(x => x.PvDate, x => x.PvCount);
		var dates = new List<string>();
		var counts = new List<long>();

		for (var date = startDate; date <= endDate; date = date.AddDays(1)) {
			dates.Add(date.ToString("MM-dd"));
			counts.Add(pvMap.GetValueOrDefault(date, 0));
		}

		return new AdminDashboardPvStatisticsDto(dates, counts);
	}

	async Task<AdminDashboardStatisticsDto> IGetAdminDashboardStatisticsQueryService.GetAsync(
		CancellationToken cancellationToken){
		var summary = await ((IGetBlogStatisticsQueryService)this).GetAsync(cancellationToken);
		return new AdminDashboardStatisticsDto(
			summary.ArticleTotalCount,
			summary.CategoryTotalCount,
			summary.TagTotalCount,
			summary.ColumnTotalCount,
			summary.PvTotalCount);
	}

	async Task<BlogStatisticsDto> IGetBlogStatisticsQueryService.GetAsync(CancellationToken cancellationToken){
		var articleTotalCount = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0)
			.CountAsync();

		var categoryTotalCount = await dbContext.Client.Queryable<CategoryDataModel>()
			.Where(x => x.IsDeleted == 0)
			.CountAsync();

		var tagTotalCount = await dbContext.Client.Queryable<TagDataModel>()
			.Where(x => x.IsDeleted == 0)
			.CountAsync();

		var columnTotalCount = await dbContext.Client.Queryable<ColumnDataModel>()
			.Where(x => x.IsDeleted == 0)
			.CountAsync();

		var pvTotalCount = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0)
			.SumAsync(x => x.ReadCount);

		return new BlogStatisticsDto(articleTotalCount, categoryTotalCount, tagTotalCount, columnTotalCount,
			pvTotalCount);
	}
}