using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IArticleDraftRepository {
    Task<PagedResult<ArticleDraftListItemDto>> GetListAsync(int page, int size, CancellationToken ct);
    Task<ArticleDraftDataModel?> GetAsync(long id);
    Task<ArticleDraftDataModel?> GetByArticleAsync(long articleId);
    Task<bool> ExistsByArticleAsync(long articleId);
    Task<bool> LockAsync(long id, CancellationToken ct);
    Task EnsureGeneralVersionAsync(long tagId, CancellationToken ct);
    Task<ArticleDraftDto> GetDetailAsync(ArticleDraftDataModel row);
    Task<long> SaveAsync(ArticleDraftDataModel row, bool isNew, string content);
    Task DeleteAsync(long id);
    Task<bool> IsImageUsedAsync(string image);
}
