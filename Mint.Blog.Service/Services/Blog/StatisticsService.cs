using Mint.Blog.Model.Vos.Blog.Statistics;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class StatisticsService(IStatisticsRepository statisticsRepository) : IStatisticsService {
    public async Task TrackArticleReadAsync(long articleId, CancellationToken cancellationToken = default) {
        var article = await statisticsRepository.GetArticleAsync(articleId, cancellationToken);
        if (article is null) return;
        article.ReadCount += 1;
        await statisticsRepository.UpdateArticleAsync(article, cancellationToken);
        var today = DateOnly.FromDateTime(DateTime.UtcNow.Date);
        var record = await statisticsRepository.GetPvRecordAsync(today, cancellationToken);
        if (record is null) {
            await statisticsRepository.AddPvRecordAsync(new Mint.Blog.Model.Entitys.Blog.Statistics.StatisticsArticlePvDataModel {
                Id = await statisticsRepository.GetNextPvRecordIdAsync(cancellationToken), PvDate = today, PvCount = 1,
                CreatedAt = DateTime.UtcNow, UpdatedAt = DateTime.UtcNow
            }, cancellationToken);
            return;
        }
        record.PvCount += 1;
        record.UpdatedAt = DateTime.UtcNow;
        await statisticsRepository.UpdatePvRecordAsync(record, cancellationToken);
    }
    public async Task EnsureTomorrowPvRecordAsync(CancellationToken cancellationToken = default) {
        var tomorrow = DateOnly.FromDateTime(DateTime.UtcNow.Date.AddDays(1));
        if (await statisticsRepository.PvRecordExistsAsync(tomorrow, cancellationToken)) return;
        await statisticsRepository.AddPvRecordAsync(new Mint.Blog.Model.Entitys.Blog.Statistics.StatisticsArticlePvDataModel {
            Id = await statisticsRepository.GetNextPvRecordIdAsync(cancellationToken), PvDate = tomorrow, PvCount = 0,
            CreatedAt = DateTime.UtcNow, UpdatedAt = DateTime.UtcNow
        }, cancellationToken);
    }
    public Task<BlogStatisticsDto> GetBlogAsync(CancellationToken cancellationToken = default) =>
        statisticsRepository.GetTotalsAsync(true, cancellationToken);

    public async Task<AdminDashboardStatisticsDto> GetDashboardAsync(CancellationToken cancellationToken = default) {
        var totals = await statisticsRepository.GetTotalsAsync(false, cancellationToken);
        return new AdminDashboardStatisticsDto(totals.ArticleTotalCount, totals.CategoryTotalCount, totals.TagTotalCount, totals.ColumnTotalCount, totals.PvTotalCount);
    }

    public async Task<AdminDashboardPvStatisticsDto> GetPvAsync(CancellationToken cancellationToken = default) {
        var endDate = DateOnly.FromDateTime(DateTime.UtcNow.Date);
        var startDate = endDate.AddDays(-6);
        var records = await statisticsRepository.GetPvRecordsAsync(startDate, endDate, cancellationToken);
        var pvMap = records.ToDictionary(x => x.PvDate, x => x.PvCount);
        var dates = new List<string>();
        var counts = new List<long>();
        for (var date = startDate; date <= endDate; date = date.AddDays(1)) {
            dates.Add(date.ToString("MM-dd"));
            counts.Add(pvMap.GetValueOrDefault(date, 0));
        }
        return new AdminDashboardPvStatisticsDto(dates, counts);
    }

    public async Task<AdminDashboardPublishArticleStatisticsDto> GetPublishAsync(CancellationToken cancellationToken = default) {
        var endDate = DateOnly.FromDateTime(DateTime.UtcNow.Date);
        var startDate = endDate.AddYears(-1);
        var articles = await statisticsRepository.GetPublishDatesAsync(startDate.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc), endDate.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc), cancellationToken);
        var countsByDate = articles.GroupBy(x => DateOnly.FromDateTime(x.CreatedAt.UtcDateTime.Date)).ToDictionary(group => group.Key, group => (long)group.Count());
        var dates = new List<string>();
        var counts = new List<long>();
        for (var date = startDate; date <= endDate; date = date.AddDays(1)) {
            dates.Add(date.ToString("yyyy-MM-dd"));
            counts.Add(countsByDate.GetValueOrDefault(date, 0));
        }
        return new AdminDashboardPublishArticleStatisticsDto(dates, counts);
    }
}
