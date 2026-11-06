using Mint.Blog.Model.Dtos.Blog.Column;
using Mint.Blog.Model.Entitys.Blog.Column;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Column;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IColumnRepository {
    Task<ColumnDataModel?> GetByIdAsync(long id, CancellationToken cancellationToken = default);
    Task<long> AddAsync(ColumnDataModel column, CancellationToken cancellationToken = default);
    Task UpdateAsync(ColumnDataModel column, CancellationToken cancellationToken = default);
    Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default);
    Task<bool> MoveAsync(long id, string move, CancellationToken cancellationToken = default);
    Task DeleteAsync(long id, CancellationToken cancellationToken = default);
    Task<bool> ExistsByTitleAsync(string title, long? excludeId = null, CancellationToken cancellationToken = default);
    Task<int> GetMaxWeightAsync(CancellationToken cancellationToken = default);
    Task UpdateCatalogAsync(long columnId, IReadOnlyCollection<ColumnCatalogUpsertModel> catalogs, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<long>> GetExistingArticleIdsAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default);
    Task<IReadOnlyDictionary<long, string>> GetArticleTitlesAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<long>> FilterOccupiedArticleIdsAsync(long columnId, IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<ColumnCatalogDataModel>> GetCatalogsAsync(IReadOnlyCollection<long> columnIds, CancellationToken cancellationToken = default);
    Task<IReadOnlySet<long>> GetValidArticleIdsAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default);
    Task<PagedResult<ColumnDataModel>> GetPageAsync(GetAdminColumnPageListQuery query, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<ColumnDataModel>> GetPublishedAsync(CancellationToken cancellationToken = default);
}
