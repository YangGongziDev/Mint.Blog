using Mint.Blog.Model.Dtos.Blog.Category;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Category;
using Mint.Blog.Model.Entitys.Blog.Category;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using SqlSugar;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class CategoryRepository(ISqlSugarDbContext dbContext) : ICategoryRepository {
    public Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default) => ExistsAsync(id, false, cancellationToken);
    public Task<bool> ExistsAsync(long id, bool includeDeleted, CancellationToken cancellationToken = default) {
        var query = dbContext.Client.Queryable<CategoryDataModel>().Where(x => x.Id == id);
        if (!includeDeleted) query = query.Where(x => x.IsDeleted == 0);
        return query.AnyAsync();
    }
    public async Task<long> AddAsync(string name, CancellationToken cancellationToken = default) {
        var now = DateTimeOffset.UtcNow;
        return await dbContext.Client.Insertable(new CategoryDataModel {
            Name = name, CreatedAt = now, UpdatedAt = now, IsDeleted = 0, ArticlesTotal = 0, Sort = 0
        }).ExecuteReturnSnowflakeIdAsync();
    }
    public Task UpdateAsync(long id, string name, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable<CategoryDataModel>()
            .SetColumns(x => new CategoryDataModel { Name = name, UpdatedAt = DateTimeOffset.UtcNow })
            .Where(x => x.Id == id && x.IsDeleted == 0).ExecuteCommandAsync();
    public Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable<CategoryDataModel>()
            .SetColumns(x => new CategoryDataModel { Sort = sort, UpdatedAt = DateTimeOffset.UtcNow })
            .Where(x => x.Id == id && x.IsDeleted == 0).ExecuteCommandAsync();
    public async Task MoveSortFirstAsync(long id, CancellationToken cancellationToken = default) {
        var first = await dbContext.Client.Queryable<CategoryDataModel>().Where(x => x.IsDeleted == 0).OrderBy(x => x.Sort).FirstAsync();
        await UpdateSortAsync(id, first is null ? 0 : checked((int)((first.Sort ?? 0) - 1)), cancellationToken);
    }
    public async Task MoveSortLastAsync(long id, CancellationToken cancellationToken = default) {
        var last = await dbContext.Client.Queryable<CategoryDataModel>().Where(x => x.IsDeleted == 0).OrderByDescending(x => x.Sort).FirstAsync();
        await UpdateSortAsync(id, checked((int)((last?.Sort ?? 0) + 1)), cancellationToken);
    }
    public async Task DeleteAsync(long id, int deleteType = 1, CancellationToken cancellationToken = default) {
        switch (deleteType) {
            case 1:
                await dbContext.Client.Updateable<CategoryDataModel>().SetColumns(x => new CategoryDataModel { IsDeleted = 1, UpdatedAt = DateTimeOffset.UtcNow }).Where(x => x.Id == id).ExecuteCommandAsync();
                break;
            case 2:
                await dbContext.Client.Deleteable<CategoryDataModel>().Where(x => x.Id == id).ExecuteCommandAsync();
                break;
            case 3:
                await dbContext.Client.Updateable<CategoryDataModel>().SetColumns(x => new CategoryDataModel { IsDeleted = 0, UpdatedAt = DateTimeOffset.UtcNow }).Where(x => x.Id == id).ExecuteCommandAsync();
                break;
            default:
                throw new ArgumentOutOfRangeException(nameof(deleteType), "Unsupported delete type.");
        }
    }
    public async Task<IReadOnlyCollection<CategoryListItemDto>> GetAsync(CancellationToken cancellationToken = default) {
        var categories = await dbContext.Client.Queryable<CategoryDataModel>().Where(x => x.IsDeleted == 0).OrderBy(x => x.Sort).OrderBy(x => x.Name).ToListAsync();
        return await MapToListItemsAsync(categories, cancellationToken);
    }
    public async Task<PagedResult<CategoryListItemDto>> GetAsync(CategoryPageListQuery query, CancellationToken cancellationToken = default) {
        var page = Math.Max(1, query.PageNumber);
        var size = Math.Clamp(query.PageSize, 1, 100);
        var keyword = (query.Name ?? query.Keyword)?.Trim();
        var rows = dbContext.Client.Queryable<CategoryDataModel>();
        if (!string.IsNullOrWhiteSpace(keyword)) rows = rows.Where(x => x.Name.Contains(keyword));
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
            "timeasc" => rows.OrderBy(x => x.CreatedAt).OrderBy(x => x.Sort).OrderBy(x => x.Name),
            "timedesc" => rows.OrderByDescending(x => x.CreatedAt).OrderBy(x => x.Sort).OrderBy(x => x.Name),
            _ => rows.OrderBy(x => x.Sort).OrderBy(x => x.Name).OrderByDescending(x => x.CreatedAt)
        };
        var categories = await rows.Skip((page - 1) * size).Take(size).ToListAsync();
        return new PagedResult<CategoryListItemDto>(await MapToListItemsAsync(categories, cancellationToken), page, size, total);
    }
    private async Task<CategoryListItemDto[]> MapToListItemsAsync(IReadOnlyCollection<CategoryDataModel> categories, CancellationToken cancellationToken) {
        cancellationToken.ThrowIfCancellationRequested();
        if (categories.Count == 0) return [];
        var parameters = categories.Select((category, i) => new SugarParameter("@id" + i, category.Id)).ToArray();
        var sql = "SELECT c.id,COUNT(a.id)::int AS total FROM blog_category c JOIN blog_tag t ON t.category_id=c.id AND t.is_deleted=0 JOIN blog_article a ON a.tag_id=t.id AND a.is_deleted=0 AND a.visibility=1 JOIN blog_tag_version v ON v.id=a.tag_version_id AND v.tag_id=t.id AND v.is_deleted=0 WHERE c.is_deleted=0 AND c.id IN (" + string.Join(",", parameters.Select(x => x.ParameterName)) + ") GROUP BY c.id";
        var totals = (await dbContext.Client.Ado.SqlQueryAsync<CategoryCount>(sql, parameters)).ToDictionary(x => x.Id, x => x.Total);
        return categories.Select(c => new CategoryListItemDto(c.Id, c.Name, totals.GetValueOrDefault(c.Id), c.Sort, c.CreatedAt, c.IsDeleted)).ToArray();
    }
    private sealed class CategoryCount {
        public long Id { get; set; }
        public int Total { get; set; }
    }
}
