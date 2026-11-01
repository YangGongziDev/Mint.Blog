using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Column;
using Mint.Blog.Model.Entitys.Blog.Friend;
using Mint.Blog.Model.Entitys.Blog.Gallery;
using Mint.Blog.Model.Entitys.Blog.Setting;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class ImageRepository(ISqlSugarDbContext dbContext) : IImageRepository {
    public async Task<Mint.Blog.Model.Vos.Blog.Upload.ImageReferencesData> GetReferencesAsync(string imageUrl, CancellationToken cancellationToken = default) {
        var covers = await dbContext.Client.Queryable<ArticleDataModel>().Where(x => x.Cover == imageUrl)
            .Select(x => new Mint.Blog.Model.Vos.Blog.Upload.ImageReferenceRow { Id = x.Id, Title = x.Title }).ToListAsync();
        var columns = await dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.Cover == imageUrl)
            .Select(x => new Mint.Blog.Model.Vos.Blog.Upload.ImageReferenceRow { Id = x.Id, Title = x.Title }).ToListAsync();
        var contents = await dbContext.Client.Queryable<ArticleContentDataModel>().InnerJoin<ArticleDataModel>((content, article) => content.ArticleId == article.Id)
            .Where(content => content.Content.Contains(imageUrl))
            .Select((content, article) => new Mint.Blog.Model.Vos.Blog.Upload.ImageReferenceRow { Id = article.Id, Title = article.Title }).ToListAsync();
        var draftCovers = await dbContext.Client.Queryable<ArticleDraftDataModel>().Where(x => x.ArticleId != null && x.Cover == imageUrl)
            .Select(x => new Mint.Blog.Model.Vos.Blog.Upload.ImageReferenceRow { Id = x.ArticleId!.Value, Title = x.Title }).ToListAsync();
        var draftContents = await dbContext.Client.Queryable<ArticleDraftContentDataModel>().InnerJoin<ArticleDraftDataModel>((content, draft) => content.DraftId == draft.Id)
            .Where((content, draft) => draft.ArticleId != null && content.Content.Contains(imageUrl))
            .Select((content, draft) => new Mint.Blog.Model.Vos.Blog.Upload.ImageReferenceRow { Id = draft.ArticleId!.Value, Title = draft.Title }).ToListAsync();
        var setting = await dbContext.Client.Queryable<BlogSettingDataModel>().Select(x => new { x.Name, x.Logo, x.Avatar }).SingleAsync();
        var gallery = await dbContext.Client.Queryable<GalleryImageDataModel>().Where(x => x.Url == imageUrl)
            .Select(x => new Mint.Blog.Model.Vos.Blog.Upload.ImageReferenceRow { Id = x.Id, Title = x.Name }).ToListAsync();
        var friends = await dbContext.Client.Queryable<FriendDataModel>().Where(x => x.Avatar == imageUrl)
            .Select(x => new Mint.Blog.Model.Vos.Blog.Upload.ImageReferenceRow { Id = x.Id, Title = x.Name }).ToListAsync();
        return new(covers, columns, contents, draftCovers, draftContents, setting?.Name, setting?.Logo, setting?.Avatar, gallery, friends);
    }
    public async Task<long?> GetFirstColumnArticleIdAsync(long columnId, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<ColumnCatalogDataModel>()
            .Where(x => x.ColumnId == columnId && x.Level == 2 && x.ArticleId != null && x.ArticleId > 0 && x.IsDeleted == 0)
            .OrderBy(x => x.Sort).Select(x => x.ArticleId).FirstAsync();
    public async Task<bool> IsUsedAsync(string image, CancellationToken cancellationToken = default) {
        if (await dbContext.Client.Queryable<ArticleDataModel>().Where(x => x.Cover == image).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ArticleContentDataModel>().Where(x => x.Content.Contains(image)).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ArticleDraftDataModel>().Where(x => x.Cover == image).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ColumnDataModel>().Where(x => x.Cover == image).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<ArticleDraftContentDataModel>().Where(x => x.Content.Contains(image)).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<BlogSettingDataModel>().Where(x => x.Logo == image || x.Avatar == image).AnyAsync()) return true;
        if (await dbContext.Client.Queryable<GalleryImageDataModel>().Where(x => x.Url == image).AnyAsync()) return true;
        return await dbContext.Client.Queryable<FriendDataModel>().Where(x => x.Avatar == image).AnyAsync();
    }
    public Task ReplaceArticleCoversAsync(string oldUrl, string newUrl, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable<ArticleDataModel>().SetColumns(x => new ArticleDataModel { Cover = newUrl }).Where(x => x.Cover == oldUrl).ExecuteCommandAsync(cancellationToken);
    public Task ReplaceDraftCoversAsync(string oldUrl, string newUrl, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable<ArticleDraftDataModel>().SetColumns(x => new ArticleDraftDataModel { Cover = newUrl }).Where(x => x.Cover == oldUrl).ExecuteCommandAsync(cancellationToken);
    public async Task<IReadOnlyCollection<ArticleContentDataModel>> GetArticleContentsAsync(string image, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<ArticleContentDataModel>().Where(x => x.Content.Contains(image)).ToListAsync(cancellationToken);
    public async Task<IReadOnlyCollection<ArticleDraftContentDataModel>> GetDraftContentsAsync(string image, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<ArticleDraftContentDataModel>().Where(x => x.Content.Contains(image)).ToListAsync(cancellationToken);
    public async Task<IReadOnlyCollection<BlogSettingDataModel>> GetSettingsAsync(string image, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<BlogSettingDataModel>().Where(x => x.Logo == image || x.Avatar == image).ToListAsync(cancellationToken);
    public Task UpdateArticleContentAsync(ArticleContentDataModel content, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable(content).UpdateColumns(x => new { x.Content }).ExecuteCommandAsync(cancellationToken);
    public Task UpdateDraftContentAsync(ArticleDraftContentDataModel content, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable(content).UpdateColumns(x => new { x.Content }).ExecuteCommandAsync(cancellationToken);
    public Task UpdateSettingAsync(BlogSettingDataModel setting, CancellationToken cancellationToken = default) =>
        dbContext.Client.Updateable(setting).UpdateColumns(x => new { x.Logo, x.Avatar }).ExecuteCommandAsync(cancellationToken);
}
