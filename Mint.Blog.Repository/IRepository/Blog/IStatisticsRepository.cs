using Mint.Blog.Model.Entitys.Blog.Statistics;
using Mint.Blog.Model.Vos.Blog.Statistics;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IStatisticsRepository {
    Task<IReadOnlyCollection<ArticlePublishDateRow>> GetPublishDatesAsync(DateTime startTime, DateTime endExclusive, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<StatisticsArticlePvDataModel>> GetPvRecordsAsync(DateOnly startDate, DateOnly endDate, CancellationToken cancellationToken = default);
    Task<BlogStatisticsDto> GetTotalsAsync(bool publicOnly, CancellationToken cancellationToken = default);
    Task<Mint.Blog.Model.Entitys.Blog.Article.ArticleDataModel?> GetArticleAsync(long id, CancellationToken cancellationToken = default);
    Task UpdateArticleAsync(Mint.Blog.Model.Entitys.Blog.Article.ArticleDataModel article, CancellationToken cancellationToken = default);
    Task<StatisticsArticlePvDataModel?> GetPvRecordAsync(DateOnly date, CancellationToken cancellationToken = default);
    Task<bool> PvRecordExistsAsync(DateOnly date, CancellationToken cancellationToken = default);
    Task<long> GetNextPvRecordIdAsync(CancellationToken cancellationToken = default);
    Task AddPvRecordAsync(StatisticsArticlePvDataModel record, CancellationToken cancellationToken = default);
    Task UpdatePvRecordAsync(StatisticsArticlePvDataModel record, CancellationToken cancellationToken = default);
}
