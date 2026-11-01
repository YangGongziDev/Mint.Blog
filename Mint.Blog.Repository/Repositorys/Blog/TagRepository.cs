using Mint.Blog.Model.Dtos.Blog.Tag;
using Mint.Blog.Model.Entitys.Blog.Tag;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Tag;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using SqlSugar;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class TagRepository(ISqlSugarDbContext dbContext) : ITagRepository {
    private const string ValidCategory = "category_id IN (SELECT id FROM blog_category WHERE is_deleted=0)";
    public async Task<IReadOnlyCollection<TagListItemDto>> GetAsync(CancellationToken ct = default) {
        var tags = await dbContext.Client.Queryable<TagDataModel>().Where(x => x.IsDeleted == 0).Where(ValidCategory).OrderBy(x => x.Sort).OrderBy(x => x.Name).ToListAsync();
        return await MapAsync(tags, ct);
    }
    public async Task<PagedResult<TagListItemDto>> GetAsync(TagPageListQuery query, CancellationToken ct = default) {
        var page = Math.Max(1, query.PageNumber);
        var size = Math.Clamp(query.PageSize, 1, 100);
        var keyword = (query.Name ?? query.Keyword)?.Trim();
        var rows = dbContext.Client.Queryable<TagDataModel>();
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
        var tags = await rows.Skip((page - 1) * size).Take(size).ToListAsync();
        return new PagedResult<TagListItemDto>(await MapAsync(tags, ct), page, size, total);
    }
    public async Task<IReadOnlyCollection<long>> FilterExistingIdsAsync(IEnumerable<long> ids, CancellationToken ct = default) {
        ct.ThrowIfCancellationRequested();
        var values = ids.Distinct().ToArray();
        if (values.Length == 0) return [];
        return await dbContext.Client.Queryable<TagDataModel>().Where(x => x.IsDeleted == 0 && values.Contains(x.Id)).Where(ValidCategory).Select(x => x.Id).ToListAsync();
    }
    public Task<bool> ExistsAsync(long id, CancellationToken ct = default) => ExistsAsync(id, false, ct);
    public Task<bool> ExistsAsync(long id, bool includeDeleted, CancellationToken ct = default) {
        ct.ThrowIfCancellationRequested();
        var rows = dbContext.Client.Queryable<TagDataModel>().Where(x => x.Id == id);
        if (!includeDeleted) rows = rows.Where(x => x.IsDeleted == 0).Where(ValidCategory);
        return rows.AnyAsync();
    }
    public async Task<TagDataModel?> GetSnapshotAsync(long id, CancellationToken ct) =>
        await dbContext.Client.Queryable<TagDataModel>().Where(x => x.Id == id).SingleAsync();
    public async Task<IReadOnlyCollection<long>> LockCategorySnapshotAsync(long id, CancellationToken ct) =>
        await dbContext.Client.Ado.SqlQueryAsync<long>("SELECT category_id FROM blog_tag WHERE id=@id AND is_deleted=0 FOR UPDATE", new { id });
    public Task<bool> NameExistsAsync(string name, long excludingId, CancellationToken ct) =>
        dbContext.Client.Queryable<TagDataModel>().Where(x => x.Name == name && x.Id != excludingId).AnyAsync();
    public Task<bool> HasValidCategoryAsync(long id, CancellationToken ct) =>
        dbContext.Client.Queryable<TagDataModel>().Where(x => x.Id == id).Where(ValidCategory).AnyAsync();
    public async Task<long> AddAsync(string name, long categoryId, string logoUrl, CancellationToken ct = default) {
        var now = DateTimeOffset.UtcNow;
        return await dbContext.Client.Insertable(new TagDataModel {
            Name = name, CategoryId = categoryId, LogoUrl = logoUrl, CreatedAt = now, UpdatedAt = now,
            IsDeleted = 0, ArticlesTotal = 0, Sort = 0
        }).ExecuteReturnSnowflakeIdAsync();
    }
    public async Task UpdateAsync(long id, string name, long categoryId, string? logoUrl, CancellationToken ct = default) {
        var update = dbContext.Client.Updateable<TagDataModel>().SetColumns(x => new TagDataModel { Name = name, CategoryId = categoryId, UpdatedAt = DateTimeOffset.UtcNow });
        if (logoUrl is not null) update = update.SetColumns(x => x.LogoUrl == logoUrl);
        await update.Where(x => x.Id == id).ExecuteCommandAsync();
    }
    public Task UpdateSortAsync(long id, int sort, CancellationToken ct = default) => dbContext.Client.Updateable<TagDataModel>()
        .SetColumns(x => new TagDataModel { Sort = sort, UpdatedAt = DateTimeOffset.UtcNow }).Where(x => x.Id == id && x.IsDeleted == 0).ExecuteCommandAsync();
    public async Task MoveSortFirstAsync(long id, CancellationToken ct = default) {
        var first = await dbContext.Client.Queryable<TagDataModel>().Where(x => x.IsDeleted == 0).OrderBy(x => x.Sort).FirstAsync();
        await UpdateSortAsync(id, first is null ? 0 : checked((int)((first.Sort ?? 0) - 1)), ct);
    }
    public async Task MoveSortLastAsync(long id, CancellationToken ct = default) {
        var last = await dbContext.Client.Queryable<TagDataModel>().Where(x => x.IsDeleted == 0).OrderByDescending(x => x.Sort).FirstAsync();
        await UpdateSortAsync(id, checked((int)((last?.Sort ?? 0) + 1)), ct);
    }
    public async Task DeleteAsync(long id, int deleteType = 1, CancellationToken ct = default) {
        var deleted = deleteType == 1 ? (short)1 : (short)0;
        await dbContext.Client.Updateable<TagDataModel>().SetColumns(x => new TagDataModel { IsDeleted = deleted, UpdatedAt = DateTimeOffset.UtcNow }).Where(x => x.Id == id).ExecuteCommandAsync();
    }
    private async Task<TagListItemDto[]> MapAsync(IReadOnlyCollection<TagDataModel> tags, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        if (tags.Count == 0) return [];
        await ResourceRepository.EnsureGeneralVersionsAsync(dbContext, tags.Select(t => t.Id), ct);
        var parameters = tags.Select((x, i) => new SugarParameter("@id" + i, x.Id)).ToArray();
        var sql = "SELECT t.id,c.name AS categoryname,(SELECT COUNT(*) FROM blog_tag_version v WHERE v.tag_id=t.id AND v.is_deleted=0) AS versioncount,(SELECT COUNT(*) FROM blog_article a JOIN blog_tag_version v ON v.id=a.tag_version_id AND v.tag_id=a.tag_id AND v.is_deleted=0 WHERE a.tag_id=t.id AND a.is_deleted=0 AND a.visibility=1 AND t.is_deleted=0 AND c.is_deleted=0) AS articlestotal FROM blog_tag t JOIN blog_category c ON c.id=t.category_id WHERE t.id IN (" + string.Join(",", parameters.Select(x => x.ParameterName)) + ")";
        var counts = (await dbContext.Client.Ado.SqlQueryAsync<Counts>(sql, parameters)).ToDictionary(x => x.Id);
        return tags.Select(t => {
            var c = counts.GetValueOrDefault(t.Id) ?? new Counts();
            return new TagListItemDto(t.Id, t.Name, c.ArticlesTotal, t.Sort, t.CreatedAt, t.IsDeleted, t.LogoUrl,
                c.VersionCount, t.CategoryId, c.CategoryName, t.ShowInNavigation == 1, t.NavigationDescription);
        }).ToArray();
    }
    private sealed class Counts {
        public long Id { get; set; }
        public string CategoryName { get; set; } = "";
        public int VersionCount { get; set; }
        public int ArticlesTotal { get; set; }
    }
}
