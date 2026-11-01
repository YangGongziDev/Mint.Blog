using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Column;
using Mint.Blog.Model.Entitys.Blog.Friend;
using Mint.Blog.Model.Entitys.Blog.Setting;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class ArticleDraftRepository(ISqlSugarDbContext dbContext) : IArticleDraftRepository {
    public async Task<PagedResult<ArticleDraftListItemDto>> GetListAsync(int page, int size, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        var rows = dbContext.Client.Queryable<ArticleDraftDataModel>();
        var total = await rows.CountAsync();
        var drafts = await rows.OrderByDescending(x => x.UpdatedAt).Skip((page - 1) * size).Take(size).ToListAsync();
        await ResourceRepository.EnsureGeneralVersionsAsync(dbContext, drafts.Where(d => d.TagId.HasValue).Select(d => d.TagId!.Value), ct);
        var items = new List<ArticleDraftListItemDto>();
        foreach (var draft in drafts) {
            var selection = await SelectionAsync(draft.TagId, draft.TagVersionId);
            items.Add(ArticleResponseMapping.ToDraftListItem(draft, selection));
        }
        return new(items, page, size, total);
    }
    public async Task<ArticleDraftDataModel?> GetAsync(long id) => await dbContext.Client.Queryable<ArticleDraftDataModel>().Where(x => x.Id == id).SingleAsync();
    public async Task<ArticleDraftDataModel?> GetByArticleAsync(long articleId) => await dbContext.Client.Queryable<ArticleDraftDataModel>().Where(x => x.ArticleId == articleId).OrderByDescending(x => x.UpdatedAt).FirstAsync();
    public Task<bool> ExistsByArticleAsync(long articleId) => dbContext.Client.Queryable<ArticleDraftDataModel>().Where(x => x.ArticleId == articleId).AnyAsync();
    public async Task<bool> LockAsync(long id, CancellationToken ct) {
        ct.ThrowIfCancellationRequested();
        return (await dbContext.Client.Ado.SqlQueryAsync<long>("SELECT id FROM blog_article_draft WHERE id=@id FOR UPDATE", new { id })).Count > 0;
    }
    public Task EnsureGeneralVersionAsync(long tagId, CancellationToken ct) => ResourceRepository.EnsureGeneralVersionsAsync(dbContext, [tagId], ct);
    public async Task<ArticleDraftDto> GetDetailAsync(ArticleDraftDataModel row) {
        var content = await dbContext.Client.Queryable<ArticleDraftContentDataModel>().Where(x => x.DraftId == row.Id).SingleAsync();
        return ArticleResponseMapping.ToDraftDetail(row, content?.Content ?? "", await SelectionAsync(row.TagId, row.TagVersionId));
    }
    private async Task<DraftSelection> SelectionAsync(long? tagId, long? versionId) {
        if (!tagId.HasValue) return new();
        var rows = await dbContext.Client.Ado.SqlQueryAsync<DraftSelection>("SELECT c.id AS categoryid,c.name AS categoryname,t.name AS tagname,v.name AS tagversionname,(v.is_general=1) AS isgeneral FROM blog_tag t JOIN blog_category c ON c.id=t.category_id LEFT JOIN blog_tag_version v ON v.id=@versionId AND v.tag_id=t.id WHERE t.id=@tagId", new { tagId, versionId });
        return rows.FirstOrDefault() ?? new();
    }
    public async Task<long> SaveAsync(ArticleDraftDataModel row, bool isNew, string text) {
        long id;
        if (isNew) id = await dbContext.Client.Insertable(row).ExecuteReturnSnowflakeIdAsync();
        else {
            id = row.Id;
            await dbContext.Client.Updateable(row).ExecuteCommandAsync();
        }
        var content = await dbContext.Client.Queryable<ArticleDraftContentDataModel>().Where(x => x.DraftId == id).SingleAsync();
        if (content is null)
            await dbContext.Client.Insertable(new ArticleDraftContentDataModel { DraftId = id, Content = text }).ExecuteReturnSnowflakeIdAsync();
        else {
            content.Content = text;
            await dbContext.Client.Updateable(content).ExecuteCommandAsync();
        }
        return id;
    }
    public async Task DeleteAsync(long id) {
        await dbContext.Client.Deleteable<ArticleDraftContentDataModel>().Where(x => x.DraftId == id).ExecuteCommandAsync();
        await dbContext.Client.Deleteable<ArticleDraftDataModel>().Where(x => x.Id == id).ExecuteCommandAsync();
    }
    public async Task<bool> IsImageUsedAsync(string image) {
        if (await dbContext.Client.Queryable<ArticleDataModel>().Where(x => x.Cover == image).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ArticleContentDataModel>().Where(x => x.Content.Contains(image)).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ArticleDraftDataModel>().Where(x => x.Cover == image).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ArticleDraftContentDataModel>().Where(x => x.Content.Contains(image)).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.Cover == image).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<BlogSettingDataModel>().Where(x => x.Logo == image || x.Avatar == image).AnyAsync()) return true;
        return await dbContext.Client.Queryable<FriendDataModel>().Where(x => x.Avatar == image).AnyAsync();
    }
}
