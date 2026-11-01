using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Resource;
using Mint.Blog.Model.Vos.Blog.Resource;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Entitys.Blog.Resource;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using ResourceEntity = Mint.Blog.Model.Entitys.Blog.Resource.Resource;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class ResourceRepository(ISqlSugarDbContext db) : IResourceRepository {
    private const string SelectionColumns = "t.id AS tagid,v.id AS tagversionid,t.name AS tagname,v.name AS tagversionname,c.id AS categoryid,c.name AS categoryname,(v.is_general=1) AS isgeneral";
    private const string ResourceColumns = "r.id,r.tag_id AS tagid,r.tag_version_id AS tagversionid,r.title,r.description,r.url,r.kind,(r.is_featured=1) AS isfeatured,r.sort,(r.is_deleted=1) AS isdeleted";
    private const string VersionColumns = "v.id,v.tag_id AS tagid,v.name,v.sort,(v.is_general=1) AS isgeneral";
    private const string ResourceJoins = " FROM blog_resource r JOIN blog_tag t ON t.id=r.tag_id JOIN blog_category c ON c.id=t.category_id JOIN blog_tag_version v ON v.id=r.tag_version_id AND v.tag_id=t.id";
    private Task<List<T>> Rows<T>(string sql, object? args, CancellationToken ct){
        ct.ThrowIfCancellationRequested();
        return db.Client.Ado.SqlQueryAsync<T>(sql, args);
    }
    private async Task<bool> Exists(string sql, object args, CancellationToken ct) => (await Rows<long>(sql, args, ct)).Count > 0;
    private Task<int> Execute(string sql, object args, CancellationToken ct){
        ct.ThrowIfCancellationRequested();
        return db.Client.Ado.ExecuteCommandAsync(sql, args);
    }
    public static async Task EnsureGeneralVersionsAsync(ISqlSugarDbContext context, IEnumerable<long> tagIds, CancellationToken ct){
        ct.ThrowIfCancellationRequested();
        var ids = tagIds.Distinct().ToArray();
        if (ids.Length == 0) return;
        var parameters = ids.Select((id, i) => new SqlSugar.SugarParameter("@tag" + i, id)).ToArray();
        var invalid = await context.Client.Ado.SqlQueryAsync<long>("SELECT t.id FROM blog_tag t LEFT JOIN blog_tag_version v ON v.tag_id=t.id AND v.is_general=1 WHERE t.id IN (" + string.Join(",", parameters.Select(p => p.ParameterName)) + ") GROUP BY t.id HAVING count(v.id)<>1 OR bool_or(v.id<=0 OR v.is_deleted<>0)", parameters);
        if (invalid.Count > 0) throw new BusinessException("general_version_missing", "标签通用版本数据异常，请管理员修复。");
    }
    private Task EnsureGeneralAsync(long tagId, CancellationToken ct) => EnsureGeneralVersionsAsync(db, [tagId], ct);
    public Task<bool> LockCategoryAsync(long id, CancellationToken ct, bool includeDeleted = false) => Exists("SELECT id FROM blog_category WHERE id=@id" + (includeDeleted ? "" : " AND is_deleted=0") + " FOR UPDATE", new { id }, ct);
    public async Task LockTagsAsync(IEnumerable<long> ids, CancellationToken ct, bool includeDeleted = false){
        var snapshots = new SortedDictionary<long, long>();
        foreach (var id in ids.Distinct().Order()) {
            var categories = await Rows<long>("SELECT category_id FROM blog_tag WHERE id=@id", new { id }, ct);
            if (id <= 0 || categories.Count != 1) throw new BusinessException("tag_not_found", "标签不存在。");
            snapshots.Add(id, categories[0]);
        }
        foreach (var category in snapshots.Values.Distinct().Order())
            if (!await LockCategoryAsync(category, ct, includeDeleted)) throw new BusinessException("category_not_found", "分类不存在或已删除。");
        foreach (var pair in snapshots) {
            var categories = await Rows<long>("SELECT category_id FROM blog_tag WHERE id=@id" + (includeDeleted ? "" : " AND is_deleted=0") + " FOR UPDATE", new { id = pair.Key }, ct);
            if (categories.Count != 1 || categories[0] != pair.Value) throw new BusinessException("tag_changed", "标签已删除或分类已被修改，请刷新重试。");
            if (!includeDeleted) await EnsureGeneralAsync(pair.Key, ct);
        }
    }
    public async Task<bool> LockTagAsync(long id, CancellationToken ct, bool includeDeleted = false){
        await LockTagsAsync([id], ct, includeDeleted);
        return true;
    }
    public Task<bool> TagHasNavigationDataAsync(long tagId, CancellationToken ct) => Exists("SELECT id FROM blog_tag_version WHERE tag_id=@tagId LIMIT 1", new { tagId }, ct);
    public Task<bool> CategoryHasTagsAsync(long categoryId, bool includeDeleted, CancellationToken ct) => Exists("SELECT id FROM blog_tag WHERE category_id=@categoryId" + (includeDeleted ? "" : " AND is_deleted=0") + " LIMIT 1", new { categoryId }, ct);
    public async Task<ResourceEntity?> GetResourceAsync(long id, bool forUpdate, CancellationToken ct, bool includeDeleted = false){
        var row = (await Rows<ResourceDto>($"SELECT {ResourceColumns} FROM blog_resource r WHERE r.id=@id" + (includeDeleted ? "" : " AND r.is_deleted=0") + (forUpdate ? " FOR UPDATE" : ""), new { id }, ct)).SingleOrDefault();
        return row is null ? null : new ResourceEntity(row.Id, row.TagId, row.TagVersionId, row.Title, row.Description, row.Url, row.Kind, row.IsFeatured, row.Sort, row.IsDeleted);
    }
    public async Task<TagVersion?> GetVersionAsync(long tagId, long id, bool forUpdate, CancellationToken ct){
        var row = (await Rows<TagVersionDto>($"SELECT {VersionColumns} FROM blog_tag_version v WHERE v.id=@id AND v.tag_id=@tagId AND v.is_deleted=0" + (forUpdate ? " FOR UPDATE" : ""), new { id, tagId }, ct)).SingleOrDefault();
        return row is null ? null : new TagVersion(row.Id, row.TagId, row.Name, row.Sort, row.IsGeneral);
    }
    public Task<bool> VersionNameExistsAsync(long tagId, string name, long excludingId, CancellationToken ct) => Exists("SELECT id FROM blog_tag_version WHERE tag_id=@tagId AND name=@name AND id<>@excludingId", new { tagId, name, excludingId }, ct);
    public Task<bool> ResourceUrlExistsAsync(long tagId, long tagVersionId, string url, long excludingId, CancellationToken ct) => Exists("SELECT id FROM blog_resource WHERE tag_id=@tagId AND tag_version_id=@tagVersionId AND url=@url AND id<>@excludingId", new { tagId, tagVersionId, url, excludingId }, ct);
    public Task<bool> VersionReferencedAsync(long id, CancellationToken ct) => Exists("SELECT tag_version_id FROM blog_resource WHERE tag_version_id=@id UNION ALL SELECT tag_version_id FROM blog_article WHERE tag_version_id=@id UNION ALL SELECT tag_version_id FROM blog_article_draft WHERE tag_version_id=@id LIMIT 1", new { id }, ct);
    public async Task<long> SaveVersionAsync(TagVersion v, CancellationToken ct){
        var args = new { v.Id, v.TagId, v.Name, v.Sort, isGeneral = v.IsGeneral ? 1 : 0, isDeleted = v.IsDeleted ? 1 : 0 };
        if (v.Id == 0) return (await Rows<long>("INSERT INTO blog_tag_version(tag_id,name,sort,is_general) VALUES(@TagId,@Name,@Sort,@isGeneral) RETURNING id", args, ct)).Single();
        var changed = await Execute("UPDATE blog_tag_version SET tag_id=@TagId,name=@Name,sort=@Sort,is_deleted=@isDeleted,update_time=CURRENT_TIMESTAMP WHERE id=@Id AND is_general=@isGeneral AND (is_general=0 OR (tag_id=@TagId AND @isDeleted=0))", args, ct);
        if (changed != 1) throw new BusinessException("version_invalid", "通用版本不可删除、移动或更改标记。");
        return v.Id;
    }
    public async Task<long> SaveResourceAsync(ResourceEntity r, CancellationToken ct){
        var args = new { r.Id, r.TagId, r.TagVersionId, r.Title, r.Description, r.Url, r.Kind, r.Sort, isFeatured = r.IsFeatured ? 1 : 0, isDeleted = r.IsDeleted ? 1 : 0 };
        if (r.Id == 0) return (await Rows<long>("INSERT INTO blog_resource(tag_id,tag_version_id,title,description,url,kind,is_featured,sort) VALUES(@TagId,@TagVersionId,@Title,@Description,@Url,@Kind,@isFeatured,@Sort) RETURNING id", args, ct)).Single();
        await Execute("UPDATE blog_resource SET tag_id=@TagId,tag_version_id=@TagVersionId,title=@Title,description=@Description,url=@Url,kind=@Kind,is_featured=@isFeatured,sort=@Sort,is_deleted=@isDeleted,update_time=CURRENT_TIMESTAMP WHERE id=@Id", args, ct);
        return r.Id;
    }
    public async Task UpdateNavigationAsync(long tagId, bool enabled, string description, CancellationToken ct) => await Execute("UPDATE blog_tag SET show_in_navigation=@enabled,navigation_description=@description,update_time=CURRENT_TIMESTAMP WHERE id=@tagId", new { tagId, enabled = enabled ? 1 : 0, description }, ct);
    public async Task<IReadOnlyCollection<NavigationTagDto>> GetNavigationTagsAsync(bool publicOnly, long? categoryId, string? keyword, CancellationToken ct){
        var tags = await Rows<NavigationTagDto>("""
        SELECT t.id,t.name,t.logo_url AS logourl,(t.show_in_navigation=1) AS showinnavigation,
        c.id AS categoryid,c.name AS categoryname,t.navigation_description AS navigationdescription,
        (SELECT count(*) FROM blog_tag_version v WHERE v.tag_id=t.id AND v.is_deleted=0) AS versioncount,
        (SELECT count(*) FROM blog_resource r JOIN blog_tag_version v ON v.id=r.tag_version_id AND v.tag_id=r.tag_id AND v.is_deleted=0 WHERE r.tag_id=t.id AND r.is_deleted=0) AS resourcecount
        FROM blog_tag t JOIN blog_category c ON c.id=t.category_id AND c.is_deleted=0 WHERE t.is_deleted=0
        """ + (publicOnly ? " AND t.show_in_navigation=1" : "")
        + (categoryId.HasValue ? " AND c.id=@categoryId" : "")
        + (!string.IsNullOrWhiteSpace(keyword) ? " AND (strpos(lower(t.name),lower(@keyword))>0 OR strpos(lower(t.navigation_description),lower(@keyword))>0)" : "")
        + " ORDER BY t.sort NULLS LAST,t.id", new { categoryId, keyword = keyword?.Trim() }, ct);
        await EnsureGeneralVersionsAsync(db, tags.Select(t => t.Id), ct);
        return tags;
    }
    public async Task<bool> TagAvailableAsync(long tagId, bool publicOnly, CancellationToken ct){
        var available = await Exists("SELECT t.id FROM blog_tag t JOIN blog_category c ON c.id=t.category_id AND c.is_deleted=0 WHERE t.id=@tagId AND t.is_deleted=0" + (publicOnly ? " AND t.show_in_navigation=1" : ""), new { tagId }, ct);
        if (available) await EnsureGeneralAsync(tagId, ct);
        return available;
    }
    public Task<bool> VersionAvailableAsync(long tagId, long versionId, CancellationToken ct) => Exists("SELECT id FROM blog_tag_version WHERE id=@versionId AND tag_id=@tagId AND is_deleted=0", new { tagId, versionId }, ct);
    public async Task<IReadOnlyCollection<TagVersionDto>> GetVersionsAsync(long tagId, CancellationToken ct){
        var versions = await Rows<TagVersionDto>($"""
            SELECT {VersionColumns},
            (SELECT count(*) FROM blog_article a WHERE a.tag_id=v.tag_id AND a.tag_version_id=v.id AND a.is_deleted=0 AND a.visibility=1) AS articlecount,
            (SELECT count(*) FROM blog_resource r WHERE r.tag_id=v.tag_id AND r.tag_version_id=v.id AND r.is_deleted=0) AS resourcecount
            FROM blog_tag_version v JOIN blog_tag t ON t.id=v.tag_id AND t.is_deleted=0
            JOIN blog_category c ON c.id=t.category_id AND c.is_deleted=0
            WHERE v.tag_id=@tagId AND v.is_deleted=0 ORDER BY v.sort,v.id
            """, new { tagId }, ct);
        if (versions.Count(v => v.IsGeneral && v.Id > 0) != 1) throw new BusinessException("general_version_missing", "标签通用版本数据异常，请管理员修复。");
        return versions;
    }
    public async Task<PagedResult<NavigationArticleDto>> GetArticlesAsync(long tagId, NavigationArticleQuery query, CancellationToken ct){
        var where = " FROM blog_article a JOIN blog_tag t ON t.id=a.tag_id JOIN blog_category c ON c.id=t.category_id JOIN blog_tag_version v ON v.id=a.tag_version_id AND v.tag_id=a.tag_id WHERE a.is_deleted=0 AND a.visibility=1 AND t.is_deleted=0 AND c.is_deleted=0 AND v.is_deleted=0 AND t.show_in_navigation=1 AND a.tag_id=@tagId AND a.tag_version_id=@TagVersionId";
        if (!string.IsNullOrWhiteSpace(query.Keyword)) where += " AND (strpos(lower(a.title),lower(@keyword))>0 OR strpos(lower(a.summary),lower(@keyword))>0)";
        var args = new { tagId, query.TagVersionId, keyword = query.Keyword?.Trim(), skip = (query.PageNumber - 1L) * query.PageSize, take = query.PageSize };
        var total = (await Rows<int>("SELECT count(*)" + where, args, ct)).Single();
        var items = await Rows<NavigationArticleDto>("SELECT a.id,a.title,a.summary,a.cover,a.create_time AS createtime," + SelectionColumns + where + " ORDER BY a.create_time DESC,a.id DESC LIMIT @take OFFSET @skip", args, ct);
        return new PagedResult<NavigationArticleDto>(items, query.PageNumber, query.PageSize, total);
    }
    public async Task<PagedResult<ResourceDto>> GetResourcesAsync(ResourcePageQuery query, bool publicOnly, CancellationToken ct){
        var where = ResourceJoins + " WHERE r.is_deleted=@deleted";
        if (publicOnly) where += " AND t.is_deleted=0 AND c.is_deleted=0 AND v.is_deleted=0 AND t.show_in_navigation=1";
        if (query.TagId.HasValue) where += " AND r.tag_id=@TagId";
        if (query.TagVersionId.HasValue) where += " AND r.tag_version_id=@TagVersionId";
        if (query.Kind.HasValue) where += " AND r.kind=@Kind";
        if (!string.IsNullOrWhiteSpace(query.Keyword)) where += " AND (strpos(lower(r.title),lower(@keyword))>0 OR strpos(lower(r.url),lower(@keyword))>0 OR strpos(lower(r.description),lower(@keyword))>0 OR strpos(lower(t.name),lower(@keyword))>0 OR strpos(lower(v.name),lower(@keyword))>0)";
        var args = new { query.TagId, query.TagVersionId, query.Kind, deleted = !publicOnly && query.IsDeleted ? 1 : 0, keyword = query.Keyword?.Trim(), skip = (query.PageNumber - 1L) * query.PageSize, take = query.PageSize };
        var total = (await Rows<int>("SELECT count(*)" + where, args, ct)).Single();
        var resources = await Rows<ResourceDto>("SELECT " + ResourceColumns + ",t.name AS tagname,v.name AS tagversionname,c.id AS categoryid,c.name AS categoryname,(v.is_general=1) AS isgeneral" + where + " ORDER BY r.is_featured DESC,r.sort,r.id LIMIT @take OFFSET @skip", args, ct);
        await EnsureGeneralVersionsAsync(db, resources.Select(r => r.TagId), ct);
        return new PagedResult<ResourceDto>(resources, query.PageNumber, query.PageSize, total);
    }
    public async Task<ResourceDto?> GetResourceAsync(long id, CancellationToken ct){
        var resource = (await Rows<ResourceDto>($"SELECT {ResourceColumns},t.name AS tagname,v.name AS tagversionname,c.id AS categoryid,c.name AS categoryname,(v.is_general=1) AS isgeneral" + ResourceJoins + " WHERE r.id=@id", new { id }, ct)).SingleOrDefault();
        if (resource is not null) await EnsureGeneralAsync(resource.TagId, ct);
        return resource;
    }
}
