using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IArticleRepository {
    Task<IReadOnlyCollection<ArticleDataModel>> GetHomeArticlesAsync(int count, string order, CancellationToken ct);
    Task<PagedResult<ArticleDataModel>> GetArchivePageAsync(int page, int size, CancellationToken ct);
    Task<IReadOnlyCollection<ArticleDataModel>> GetArchiveArticlesAsync(DateTimeOffset? start, DateTimeOffset? end, CancellationToken ct);
    Task<IReadOnlyCollection<RssArticleDto>> GetRssAsync(CancellationToken ct);
    Task<bool> LockAsync(long id, CancellationToken ct);
    Task<ArticleDataModel?> GetByIdAsync(long id, CancellationToken ct);
    Task<long> AddAsync(ArticleDataModel article, CancellationToken ct);
    Task UpdateAsync(ArticleDataModel article, CancellationToken ct);
    Task DeleteAsync(long id, long deleteType, CancellationToken ct);
    Task PatchStateAsync(long id, bool? isTop, short? visibility, CancellationToken ct);
    Task<bool> HasValidSelectionAsync(long id);
    Task<bool> IsPublishedColumnAsync(long id);
    Task<IReadOnlyCollection<Mint.Blog.Model.Entitys.Blog.Column.ColumnCatalogDataModel>> GetCatalogsAsync(long id);
    Task<ArticleSelection> GetSelectionAsync(long id, CancellationToken ct);
    Task<Dictionary<long, ArticleSelection>> GetSelectionsAsync(IReadOnlyCollection<long> ids, CancellationToken ct);
    Task<bool> FilterVersionExistsAsync(ArticleListQuery query);
    Task<PagedResult<ArticleListItemDto>> GetListAsync(ArticleListQuery query, CancellationToken ct);
    Task<PagedResult<SearchArticleItemDto>> SearchAsync(SearchArticlesQuery query, CancellationToken ct);
}
