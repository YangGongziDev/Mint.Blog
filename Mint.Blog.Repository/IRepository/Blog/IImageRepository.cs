using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Setting;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IImageRepository {
    Task<Mint.Blog.Model.Vos.Blog.Upload.ImageReferencesData> GetReferencesAsync(string imageUrl, CancellationToken cancellationToken = default);
    Task<long?> GetFirstColumnArticleIdAsync(long columnId, CancellationToken cancellationToken = default);
    Task<bool> IsUsedAsync(string image, CancellationToken cancellationToken = default);
    Task ReplaceArticleCoversAsync(string oldUrl, string newUrl, CancellationToken cancellationToken = default);
    Task ReplaceDraftCoversAsync(string oldUrl, string newUrl, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<ArticleContentDataModel>> GetArticleContentsAsync(string image, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<ArticleDraftContentDataModel>> GetDraftContentsAsync(string image, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<BlogSettingDataModel>> GetSettingsAsync(string image, CancellationToken cancellationToken = default);
    Task UpdateArticleContentAsync(ArticleContentDataModel content, CancellationToken cancellationToken = default);
    Task UpdateDraftContentAsync(ArticleDraftContentDataModel content, CancellationToken cancellationToken = default);
    Task UpdateSettingAsync(BlogSettingDataModel setting, CancellationToken cancellationToken = default);
}
