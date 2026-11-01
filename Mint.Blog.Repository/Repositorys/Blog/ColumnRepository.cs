using Mint.Blog.Model.Dtos.Blog.Column;
using Mint.Blog.Model.Entitys.Blog.Column;
using Mint.Blog.Model.Vos;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class ColumnRepository(ISqlSugarDbContext dbContext) : IColumnRepository {
    public async Task<ColumnDataModel?> GetByIdAsync(long id, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.Id == id).SingleAsync();
    public Task<long> AddAsync(ColumnDataModel column, CancellationToken cancellationToken = default) =>
        dbContext.Client.Insertable(column).ExecuteReturnSnowflakeIdAsync();
    public Task UpdateAsync(ColumnDataModel column, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable(column).ExecuteCommandAsync();
    public Task DeleteAsync(long id, CancellationToken cancellationToken = default) =>
        dbContext.Client.Deleteable<ColumnDataModel>().Where(x => x.Id == id).ExecuteCommandAsync();
    public Task<bool> ExistsByTitleAsync(string title, long? excludeId = null, CancellationToken cancellationToken = default) {
        var query = dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.Title == title && x.IsDeleted == 0);
        if (excludeId.HasValue) query = query.Where(x => x.Id != excludeId.Value);
        return query.AnyAsync();
    }
    public async Task<int> GetMaxWeightAsync(CancellationToken cancellationToken = default) =>
        (await dbContext.Client.Queryable<ColumnDataModel>().OrderByDescending(x => x.Weight).FirstAsync())?.Weight ?? 0;
    public async Task<PagedResult<ColumnDataModel>> GetPageAsync(GetAdminColumnPageListQuery query, CancellationToken cancellationToken = default) {
        var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
        var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
        var rows = dbContext.Client.Queryable<ColumnDataModel>();
        if (!string.IsNullOrWhiteSpace(query.Title)) {
            var keyword = query.Title.Trim();
            rows = rows.Where(x => x.Title.Contains(keyword));
        }
        if (query.StartDate.HasValue) {
            var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
            rows = rows.Where(x => x.CreatedAt >= start);
        }
        if (query.EndDate.HasValue) {
            var end = query.EndDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
            rows = rows.Where(x => x.CreatedAt < end);
        }
        var count = await rows.CountAsync();
        rows = query.SortOrder?.ToLowerInvariant() switch {
            "timeasc" => rows.OrderBy(x => x.CreatedAt).OrderByDescending(x => x.Weight),
            "timedesc" => rows.OrderByDescending(x => x.CreatedAt).OrderByDescending(x => x.Weight),
            _ => rows.OrderByDescending(x => x.Weight).OrderByDescending(x => x.Sort).OrderByDescending(x => x.CreatedAt)
        };
        var items = await rows.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync();
        return new PagedResult<ColumnDataModel>(items, pageNumber, pageSize, count);
    }
    public async Task<IReadOnlyCollection<ColumnDataModel>> GetPublishedAsync(CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.IsPublish != 0 && x.IsDeleted == 0)
            .OrderByDescending(x => x.Weight).OrderByDescending(x => x.CreatedAt).ToListAsync();
    public async Task<IReadOnlyCollection<ColumnCatalogDataModel>> GetCatalogsAsync(IReadOnlyCollection<long> columnIds, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<ColumnCatalogDataModel>().Where(x => columnIds.Contains(x.ColumnId) && x.IsDeleted == 0)
            .OrderBy(x => x.Sort).OrderBy(x => x.Id).ToListAsync();
    public async Task<IReadOnlySet<long>> GetValidArticleIdsAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default) {
        if (articleIds.Count == 0) return new HashSet<long>();
        return (await dbContext.Client.Ado.SqlQueryAsync<long>(
            "SELECT a.id FROM blog_article a JOIN blog_tag t ON t.id=a.tag_id AND t.is_deleted=0 JOIN blog_category c ON c.id=t.category_id AND c.is_deleted=0 JOIN blog_tag_version v ON v.id=a.tag_version_id AND v.tag_id=t.id AND v.is_deleted=0 WHERE a.id IN (@articleIds) AND a.is_deleted=0 AND (a.visibility=1 OR a.visibility=2)",
            new { articleIds = articleIds.ToArray() })).ToHashSet();
    }
    public async Task<IReadOnlyCollection<long>> GetExistingArticleIdsAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default) {
        if (articleIds.Count == 0) return [];
        return await dbContext.Client.Ado.SqlQueryAsync<long>("SELECT id FROM blog_article WHERE id IN (@articleIds) AND is_deleted=0", new { articleIds = articleIds.ToArray() });
    }
    public async Task<IReadOnlyDictionary<long, string>> GetArticleTitlesAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default) {
        if (articleIds.Count == 0) return new Dictionary<long, string>();
        return (await dbContext.Client.Ado.SqlQueryAsync<ArticleTitleRow>("SELECT id,title FROM blog_article WHERE id IN (@articleIds)", new { articleIds = articleIds.ToArray() })).ToDictionary(x => x.Id, x => x.Title);
    }
    public async Task<IReadOnlyCollection<long>> FilterOccupiedArticleIdsAsync(long columnId, IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default) {
        if (articleIds.Count == 0) return [];
        var ids = articleIds.Distinct().ToArray();
        return (await dbContext.Client.Queryable<ColumnCatalogDataModel>().Where(x => x.ColumnId != columnId && x.ArticleId.HasValue && ids.Contains(x.ArticleId.Value))
            .Select(x => x.ArticleId).ToListAsync()).Where(x => x.HasValue).Select(x => x!.Value).Distinct().ToArray();
    }
    public async Task UpdateCatalogAsync(long columnId, IReadOnlyCollection<ColumnCatalogUpsertModel> catalogs, CancellationToken cancellationToken = default) {
        await dbContext.Client.Deleteable<ColumnCatalogDataModel>().Where(x => x.ColumnId == columnId).ExecuteCommandAsync();
        if (catalogs.Count == 0) return;
        var maxId = await dbContext.Client.Queryable<ColumnCatalogDataModel>().OrderByDescending(x => x.Id).Select(x => x.Id).FirstAsync();
        var nextId = maxId <= 0 ? 1 : maxId + 1;
        var parentMap = new Dictionary<int, long>();
        var parents = catalogs.Where(x => x.Level == 1).OrderBy(x => x.Sort).ToArray();
        for (var i = 0; i < parents.Length; i++) {
            var parent = parents[i];
            var parentId = nextId++;
            await dbContext.Client.Insertable(new ColumnCatalogDataModel {
                Id = parentId, ColumnId = columnId, ArticleId = null, Title = parent.Title, Level = 1,
                ParentId = 0, Sort = parent.Sort, CreatedAt = DateTimeOffset.UtcNow, UpdatedAt = DateTimeOffset.UtcNow,
                IsDeleted = parent.IsDeleted ? (short)1 : (short)0
            }).ExecuteCommandAsync();
            parentMap[i + 1] = parentId;
        }
        var children = catalogs.Where(x => x.Level == 2).OrderBy(x => x.ParentId).ThenBy(x => x.Sort).ToArray();
        if (children.Length == 0) return;
        var rows = children.Select(child => new ColumnCatalogDataModel {
            Id = nextId++, ColumnId = columnId, ArticleId = child.ArticleId, Title = child.Title, Level = 2,
            ParentId = parentMap.GetValueOrDefault((int)child.ParentId, 0), Sort = child.Sort,
            CreatedAt = DateTimeOffset.UtcNow, UpdatedAt = DateTimeOffset.UtcNow, IsDeleted = child.IsDeleted ? (short)1 : (short)0
        }).ToArray();
        await dbContext.Client.Insertable(rows).ExecuteCommandAsync();
    }
    private sealed class ArticleTitleRow {
        public long Id { get; set; }
        public string Title { get; set; } = string.Empty;
    }
}
