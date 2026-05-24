namespace Mint.Blog.Domain.Blog.Category.Repositories;

public interface ICategoryRepository {
	Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default);
	Task<bool> ExistsAsync(long id, bool includeDeleted, CancellationToken cancellationToken = default);
	Task<long> AddAsync(string name, CancellationToken cancellationToken = default);
	Task UpdateAsync(long id, string name, CancellationToken cancellationToken = default);
	Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default);
	Task MoveSortFirstAsync(long id, CancellationToken cancellationToken = default);
	Task MoveSortLastAsync(long id, CancellationToken cancellationToken = default);
	Task DeleteAsync(long id, int deleteType = 1, CancellationToken cancellationToken = default);
}
