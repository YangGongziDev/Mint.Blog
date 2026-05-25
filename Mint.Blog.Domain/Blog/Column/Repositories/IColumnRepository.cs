using ColumnEntity = Mint.Blog.Domain.Blog.Column.Entities.Column;
namespace Mint.Blog.Domain.Blog.Column.Repositories;

public interface IColumnRepository {
	Task<ColumnEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default);
	Task<long> AddAsync(ColumnEntity column, CancellationToken cancellationToken = default);
	Task UpdateAsync(ColumnEntity column, CancellationToken cancellationToken = default);
	Task DeleteAsync(long id, CancellationToken cancellationToken = default);
	Task<bool> ExistsByTitleAsync(string title, long? excludeId = null, CancellationToken cancellationToken = default);
	Task<int> GetMaxWeightAsync(CancellationToken cancellationToken = default);

	Task UpdateCatalogAsync(long columnId, IReadOnlyCollection<ColumnCatalogUpsertModel> catalogs,
		CancellationToken cancellationToken = default);
	Task ValidateArticleIdsAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default);
}

public sealed record ColumnCatalogUpsertModel(
	string Title,
	long? ArticleId,
	int Level,
	long ParentId,
	int Sort,
	bool IsDeleted = false);