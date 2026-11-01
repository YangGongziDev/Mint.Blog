using System.Text.RegularExpressions;
using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Column;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using SqlSugar;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class ArticleRepository(ISqlSugarDbContext dbContext) : IArticleRepository {
    private const string ValidSelection = "id IN (SELECT a.id FROM blog_article a JOIN blog_tag t ON t.id=a.tag_id AND t.is_deleted=0 JOIN blog_category c ON c.id=t.category_id AND c.is_deleted=0 JOIN blog_tag_version v ON v.id=a.tag_version_id AND v.tag_id=t.id AND v.is_deleted=0)";
    private ISugarQueryable<ArticleDataModel> PublicArticles() => dbContext.Client.Queryable<ArticleDataModel>()
        .Where(x => x.IsDeleted == 0 && x.Visibility == 1).Where(ValidSelection);
    public async Task<bool> LockAsync(long id, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        return (await dbContext.Client.Ado.SqlQueryAsync<long>("SELECT id FROM blog_article WHERE id=@id FOR UPDATE", new { id })).Count > 0;
    }
    public async Task<ArticleDataModel?> GetByIdAsync(long id, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var data = await dbContext.Client.Queryable<ArticleDataModel>().Where(x => x.Id == id).SingleAsync();
        if (data is null) return null;
        var content = await dbContext.Client.Queryable<ArticleContentDataModel>().Where(x => x.ArticleId == id).SingleAsync();
        data.Content = content?.Content ?? "";
        data.IsTop = data.Weight > 0;
        return data;
    }
    public async Task<long> AddAsync(ArticleDataModel article, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var id = await dbContext.Client.Insertable(new ArticleDataModel {
            Title = article.Title, Summary = article.Summary, Cover = article.Cover,
            TagId = article.TagId, TagVersionId = article.TagVersionId, IsDeleted = article.IsDeleted,
            ReadCount = article.ReadCount, Weight = article.IsTop ? 1 : 0, Visibility = article.Visibility,
            CreatedAt = article.CreatedAt, UpdatedAt = article.UpdatedAt
        }).ExecuteReturnSnowflakeIdAsync();
        await dbContext.Client.Insertable(new ArticleContentDataModel { ArticleId = id, Content = article.Content }).ExecuteReturnSnowflakeIdAsync();
        return id;
    }
    public async Task UpdateAsync(ArticleDataModel article, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        await dbContext.Client.Updateable<ArticleDataModel>().SetColumns(x => new ArticleDataModel {
            Title = article.Title, Summary = article.Summary, Cover = article.Cover,
            TagId = article.TagId, TagVersionId = article.TagVersionId,
            Visibility = article.Visibility, Weight = article.IsTop ? 1 : 0, UpdatedAt = article.UpdatedAt
        }).Where(x => x.Id == article.Id).ExecuteCommandAsync();
        var content = await dbContext.Client.Queryable<ArticleContentDataModel>().Where(x => x.ArticleId == article.Id).SingleAsync();
        if (content is null)
            await dbContext.Client.Insertable(new ArticleContentDataModel { ArticleId = article.Id, Content = article.Content }).ExecuteReturnSnowflakeIdAsync();
        else
            await dbContext.Client.Updateable<ArticleContentDataModel>().SetColumns(x => new ArticleContentDataModel { Content = article.Content })
                .Where(x => x.ArticleId == article.Id).ExecuteCommandAsync();
    }
    public async Task DeleteAsync(long id, long deleteType, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        if (deleteType is 1 or 3) {
            var deleted = deleteType == 1 ? (short)1 : (short)0;
            await dbContext.Client.Updateable<ArticleDataModel>().SetColumns(x => new ArticleDataModel { IsDeleted = deleted, UpdatedAt = DateTimeOffset.UtcNow })
                .Where(x => x.Id == id).ExecuteCommandAsync();
        } else {
            await dbContext.Client.Deleteable<ArticleContentDataModel>().Where(x => x.ArticleId == id).ExecuteCommandAsync();
            await dbContext.Client.Deleteable<ArticleDataModel>().Where(x => x.Id == id).ExecuteCommandAsync();
        }
    }
    public async Task PatchStateAsync(long id, bool? isTop, short? visibility, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        if (isTop.HasValue)
            await dbContext.Client.Updateable<ArticleDataModel>().SetColumns(x => new ArticleDataModel {
                Weight = isTop.Value ? 1 : 0, UpdatedAt = DateTimeOffset.UtcNow
            }).Where(x => x.Id == id && x.IsDeleted == 0).ExecuteCommandAsync();
        if (visibility.HasValue)
            await dbContext.Client.Updateable<ArticleDataModel>().SetColumns(x => new ArticleDataModel {
                Visibility = visibility.Value, UpdatedAt = DateTimeOffset.UtcNow
            }).Where(x => x.Id == id && x.IsDeleted == 0).ExecuteCommandAsync();
    }
    public Task<bool> HasValidSelectionAsync(long id) => dbContext.Client.Queryable<ArticleDataModel>().Where(x => x.Id == id).Where(ValidSelection).AnyAsync();
    public Task<bool> IsPublishedColumnAsync(long id) => dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.Id == id && x.IsDeleted == 0 && x.IsPublish != 0).AnyAsync();
    public async Task<IReadOnlyCollection<ColumnCatalogDataModel>> GetCatalogsAsync(long id) =>
        await dbContext.Client.Queryable<ColumnCatalogDataModel>().Where(x => x.ColumnId == id && x.IsDeleted == 0).ToListAsync();
    public async Task<ArticleSelection> GetSelectionAsync(long id, CancellationToken ct) => (await Selections([id], ct)).GetValueOrDefault(id) ?? new();
    public async Task<bool> FilterVersionExistsAsync(ArticleListQuery query) {
        var sql = "SELECT v.id FROM blog_tag_version v JOIN blog_tag t ON t.id=v.tag_id JOIN blog_category c ON c.id=t.category_id WHERE v.id=@versionId AND v.tag_id=@tagId";
        if (!query.IncludeColumnOnly) sql += " AND t.is_deleted=0 AND c.is_deleted=0 AND v.is_deleted=0";
        return (await dbContext.Client.Ado.SqlQueryAsync<long>(sql, new { versionId = query.TagVersionId!.Value, tagId = query.TagId!.Value })).Count > 0;
    }
    public async Task<PagedResult<ArticleListItemDto>> GetListAsync(ArticleListQuery query, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var page = Math.Max(1, query.PageNumber);
        var size = Math.Clamp(query.PageSize, 1, 100);
        var rows = query.IncludeColumnOnly ? dbContext.Client.Queryable<ArticleDataModel>().Where(x => x.Visibility == 1 || x.Visibility == 2) : PublicArticles();
        if (query.CategoryId.HasValue) rows = rows.Where("tag_id IN (SELECT id FROM blog_tag WHERE category_id=@categoryId)", new { categoryId = query.CategoryId.Value });
        if (query.TagId.HasValue) rows = rows.Where(x => x.TagId == query.TagId.Value);
        if (query.TagVersionId.HasValue) rows = rows.Where(x => x.TagVersionId == query.TagVersionId.Value);
        if (!string.IsNullOrWhiteSpace(query.Title)) rows = rows.Where(x => x.Title.Contains(query.Title.Trim()));
        if (query.StartDate.HasValue) {
            var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
            rows = rows.Where(x => x.CreatedAt >= start);
        }
        if (query.EndDate.HasValue) {
            var end = query.EndDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
            rows = rows.Where(x => x.CreatedAt < end);
        }
        var total = await rows.CountAsync();
        rows = query.SortOrder?.ToLowerInvariant() switch {
            "timeasc" => rows.OrderBy(x => x.CreatedAt).OrderByDescending(x => x.Weight),
            "timedesc" => rows.OrderByDescending(x => x.CreatedAt).OrderByDescending(x => x.Weight),
            _ => rows.OrderByDescending(x => x.Weight > 0 ? 1 : 0).OrderByDescending(x => x.CreatedAt).OrderByDescending(x => x.Id)
        };
        var articles = await rows.Skip((page - 1) * size).Take(size).ToListAsync();
        var selections = await Selections(articles.Select(x => x.Id).ToArray(), ct);
        var items = articles.Select(a => {
            var s = selections.GetValueOrDefault(a.Id) ?? new ArticleSelection();
            return new ArticleListItemDto(a.Id, a.Title, a.Summary, a.Cover, s.CategoryId, s.CategoryName,
                a.TagId, a.TagVersionId, s.TagName, s.TagVersionName, s.IsGeneral, a.Weight > 0,
                a.Visibility, a.IsDeleted, a.ReadCount, a.CreatedAt);
        }).ToArray();
        return new(items, page, size, total);
    }
    public async Task<PagedResult<SearchArticleItemDto>> SearchAsync(SearchArticlesQuery query, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var keyword = query.Keyword.Trim();
        var page = Math.Max(1, query.PageNumber);
        var size = Math.Clamp(query.PageSize, 1, 100);
        var rows = PublicArticles();
        var chinese = keyword.Any(ch => ch >= '\u4e00' && ch <= '\u9fff');
        var terms = Regex.Matches(keyword, @"[\p{L}\p{N}_]+").Select(m => m.Value + ":*").ToArray();
        if (dbContext.Client.CurrentConnectionConfig.DbType == DbType.PostgreSQL && !chinese && terms.Length > 0) {
            var prefixQuery = string.Join(" & ", terms);
            rows = rows.Where("to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(summary, '')) @@ to_tsquery('simple', @prefixQuery)", new { prefixQuery });
            rows = rows.OrderBy("ts_rank(to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(summary, '')), to_tsquery('simple', @prefixQuery)) DESC");
        } else rows = rows.Where(x => x.Title.Contains(keyword) || x.Summary.Contains(keyword));
        var total = await rows.CountAsync();
        var articles = await rows.OrderByDescending(x => x.Weight).OrderByDescending(x => x.CreatedAt).Skip((page - 1) * size).Take(size).ToListAsync();
        var selections = await Selections(articles.Select(x => x.Id).ToArray(), ct);
        var items = articles.Select(a => {
            var s = selections.GetValueOrDefault(a.Id) ?? new ArticleSelection();
            return new SearchArticleItemDto(a.Id, a.Title,
                string.IsNullOrWhiteSpace(keyword) ? a.Title : Regex.Replace(a.Title, Regex.Escape(keyword), m => $"<span style=\"color: #f73131\">{m.Value}</span>", RegexOptions.IgnoreCase),
                a.Summary, a.Cover, a.CreatedAt, a.TagId, a.TagVersionId, s.CategoryId, s.CategoryName, s.TagName, s.TagVersionName, s.IsGeneral);
        }).ToArray();
        return new(items, page, size, total);
    }
    public async Task<IReadOnlyCollection<ArticleDataModel>> GetHomeArticlesAsync(int count, string order, CancellationToken ct) {
        var rows = PublicArticles();
        rows = order switch {
            "hot" => rows.OrderByDescending(x => x.ReadCount).OrderByDescending(x => x.CreatedAt),
            "top" => rows.Where(x => x.Weight > 0).OrderByDescending(x => x.Weight).OrderByDescending(x => x.CreatedAt),
            _ => rows.OrderByDescending(x => x.CreatedAt)
        };
        return await rows.Take(count).ToListAsync();
    }
    public async Task<PagedResult<ArticleDataModel>> GetArchivePageAsync(int page, int size, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var rows = PublicArticles();
        var total = await rows.CountAsync();
        var articles = await rows.OrderByDescending(x => x.CreatedAt).Skip((page - 1) * size).Take(size).ToListAsync();
        return new(articles, page, size, total);
    }
    public async Task<IReadOnlyCollection<ArticleDataModel>> GetArchiveArticlesAsync(DateTimeOffset? start, DateTimeOffset? end, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var rows = PublicArticles();
        if (start.HasValue) rows = rows.Where(x => x.CreatedAt >= start.Value && x.CreatedAt < end!.Value).OrderByDescending(x => x.CreatedAt);
        var articles = await rows.ToListAsync();
        if (!start.HasValue) await ResourceRepository.EnsureGeneralVersionsAsync(dbContext, articles.Select(a => a.TagId), ct);
        return articles;
    }
    public async Task<IReadOnlyCollection<RssArticleDto>> GetRssAsync(CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var articles = await PublicArticles().OrderByDescending(x => x.CreatedAt).OrderByDescending(x => x.Id).Take(20).ToListAsync();
        if (articles.Count == 0) return [];
        await ResourceRepository.EnsureGeneralVersionsAsync(dbContext, articles.Select(a => a.TagId), ct);
        var ids = articles.Select(x => x.Id).ToArray();
        var contents = (await dbContext.Client.Queryable<ArticleContentDataModel>().Where(x => ids.Contains(x.ArticleId)).ToListAsync()).ToDictionary(x => x.ArticleId, x => x.Content);
        return articles.Select(x => new RssArticleDto(x.Id, x.Title, x.Summary, contents.GetValueOrDefault(x.Id, ""), x.CreatedAt, x.UpdatedAt)).ToArray();
    }
    public Task<Dictionary<long, ArticleSelection>> GetSelectionsAsync(IReadOnlyCollection<long> ids, CancellationToken ct) => Selections(ids, ct);
    private async Task<Dictionary<long, ArticleSelection>> Selections(IReadOnlyCollection<long> ids, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        if (ids.Count == 0) return [];
        var parameters = ids.Select((id, i) => new SugarParameter("@id" + i, id)).ToArray();
        var sql = "SELECT a.id,a.tag_id AS tagid,c.id AS categoryid,c.name AS categoryname,t.name AS tagname,v.name AS tagversionname,(v.is_general=1) AS isgeneral FROM blog_article a JOIN blog_tag t ON t.id=a.tag_id JOIN blog_category c ON c.id=t.category_id JOIN blog_tag_version v ON v.id=a.tag_version_id AND v.tag_id=t.id WHERE a.id IN (" + string.Join(",", parameters.Select(x => x.ParameterName)) + ")";
        var selections = await dbContext.Client.Ado.SqlQueryAsync<ArticleSelection>(sql, parameters);
        await ResourceRepository.EnsureGeneralVersionsAsync(dbContext, selections.Select(s => s.TagId), ct);
        return selections.ToDictionary(x => x.Id);
    }
}
