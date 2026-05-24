using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Statistics.Persistence;

namespace Mint.Blog.Infrastructure.Blog.Statistics.Repositories;

public sealed class StatisticsCommandRepository(ISqlSugarDbContext dbContext) {
	public async Task TrackArticleReadAsync(long articleId, CancellationToken cancellationToken = default){
		var article = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.Id == articleId && x.IsDeleted == 0)
			.SingleAsync();

		if (article is null) return;

		article.ReadCount += 1;
		await dbContext.Client.Updateable(article).ExecuteCommandAsync();

		var today = DateOnly.FromDateTime(DateTime.UtcNow.Date);
		var todayRecord = await dbContext.Client.Queryable<StatisticsArticlePvDataModel>()
			.Where(x => x.PvDate == today)
			.SingleAsync();

		if (todayRecord is null) {
			await dbContext.Client.Insertable(new StatisticsArticlePvDataModel {
				Id = await GetNextPvRecordIdAsync(),
				PvDate = today,
				PvCount = 1,
				CreatedAt = DateTime.UtcNow,
				UpdatedAt = DateTime.UtcNow
			}).ExecuteCommandAsync();

			return;
		}

		todayRecord.PvCount += 1;
		todayRecord.UpdatedAt = DateTime.UtcNow;
		await dbContext.Client.Updateable(todayRecord).ExecuteCommandAsync();
	}

	public async Task EnsureTomorrowPvRecordAsync(CancellationToken cancellationToken = default){
		var tomorrow = DateOnly.FromDateTime(DateTime.UtcNow.Date.AddDays(1));
		var exists = await dbContext.Client.Queryable<StatisticsArticlePvDataModel>()
			.AnyAsync(x => x.PvDate == tomorrow);

		if (exists) return;

		await dbContext.Client.Insertable(new StatisticsArticlePvDataModel {
			Id = await GetNextPvRecordIdAsync(),
			PvDate = tomorrow,
			PvCount = 0,
			CreatedAt = DateTime.UtcNow,
			UpdatedAt = DateTime.UtcNow
		}).ExecuteCommandAsync();
	}

	private async Task<long> GetNextPvRecordIdAsync(){
		var maxId = await dbContext.Client.Queryable<StatisticsArticlePvDataModel>()
			.OrderByDescending(x => x.Id)
			.Select(x => x.Id)
			.FirstAsync();

		return maxId <= 0 ? 1 : maxId + 1;
	}
}