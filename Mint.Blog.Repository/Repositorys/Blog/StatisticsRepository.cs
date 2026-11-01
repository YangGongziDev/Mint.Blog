using Mint.Blog.Model.Entitys.Blog.Category;
using Mint.Blog.Model.Entitys.Blog.Column;
using Mint.Blog.Model.Entitys.Blog.Tag;
using Mint.Blog.Model.Entitys.Blog.Statistics;
using Mint.Blog.Model.Vos.Blog.Statistics;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class StatisticsRepository(ISqlSugarDbContext dbContext) : IStatisticsRepository {
    public async Task<Mint.Blog.Model.Entitys.Blog.Article.ArticleDataModel?> GetArticleAsync(long id, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<Mint.Blog.Model.Entitys.Blog.Article.ArticleDataModel>().Where(x => x.Id == id && x.IsDeleted == 0).SingleAsync();
    public Task UpdateArticleAsync(Mint.Blog.Model.Entitys.Blog.Article.ArticleDataModel article, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable(article).ExecuteCommandAsync();
    public async Task<StatisticsArticlePvDataModel?> GetPvRecordAsync(DateOnly date, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<StatisticsArticlePvDataModel>().Where(x => x.PvDate == date).SingleAsync();
    public Task<bool> PvRecordExistsAsync(DateOnly date, CancellationToken cancellationToken = default) =>
        dbContext.Client.Queryable<StatisticsArticlePvDataModel>().AnyAsync(x => x.PvDate == date);
    public async Task<long> GetNextPvRecordIdAsync(CancellationToken cancellationToken = default) {
        var maxId = await dbContext.Client.Queryable<StatisticsArticlePvDataModel>().OrderByDescending(x => x.Id).Select(x => x.Id).FirstAsync();
        return maxId <= 0 ? 1 : maxId + 1;
    }
    public Task AddPvRecordAsync(StatisticsArticlePvDataModel record, CancellationToken cancellationToken = default) => dbContext.Client.Insertable(record).ExecuteCommandAsync();
    public Task UpdatePvRecordAsync(StatisticsArticlePvDataModel record, CancellationToken cancellationToken = default) => dbContext.Client.Updateable(record).ExecuteCommandAsync();
    public async Task<IReadOnlyCollection<ArticlePublishDateRow>> GetPublishDatesAsync(DateTime startTime, DateTime endExclusive, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Ado.SqlQueryAsync<ArticlePublishDateRow>("SELECT create_time AS CreatedAt FROM blog_article WHERE is_deleted=0 AND create_time>=@startTime AND create_time<@endExclusive", new { startTime, endExclusive });

    public async Task<IReadOnlyCollection<StatisticsArticlePvDataModel>> GetPvRecordsAsync(DateOnly startDate, DateOnly endDate, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<StatisticsArticlePvDataModel>().Where(x => x.PvDate >= startDate && x.PvDate <= endDate).OrderBy(x => x.PvDate).ToListAsync();

    public async Task<BlogStatisticsDto> GetTotalsAsync(bool publicOnly, CancellationToken cancellationToken = default) {
        var filter = publicOnly
            ? " AND a.visibility=1 AND EXISTS (SELECT 1 FROM blog_tag t JOIN blog_category c ON c.id=t.category_id AND c.is_deleted=0 JOIN blog_tag_version v ON v.tag_id=t.id AND v.is_deleted=0 WHERE t.id=a.tag_id AND t.is_deleted=0 AND v.id=a.tag_version_id)"
            : string.Empty;
        var articleCount = Convert.ToInt64(await dbContext.Client.Ado.GetScalarAsync("SELECT COUNT(*) FROM blog_article a WHERE a.is_deleted=0" + filter));
        var pvCount = await dbContext.Client.Ado.GetScalarAsync("SELECT COALESCE(SUM(a.read_num),0) FROM blog_article a WHERE a.is_deleted=0" + filter);
        var categoryCount = await dbContext.Client.Queryable<CategoryDataModel>().Where(x => x.IsDeleted == 0).CountAsync();
        var tags = dbContext.Client.Queryable<TagDataModel>().Where(x => x.IsDeleted == 0);
        if (publicOnly) tags = tags.Where("category_id IN (SELECT id FROM blog_category WHERE is_deleted=0)");
        var tagCount = await tags.CountAsync();
        var columns = dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.IsDeleted == 0);
        if (publicOnly) columns = columns.Where(x => x.IsPublish != 0);
        var columnCount = await columns.CountAsync();
        return new BlogStatisticsDto(articleCount, categoryCount, tagCount, columnCount, Convert.ToInt64(pvCount));
    }
}
