using Mint.Blog.Model.Dtos.Blog.Category;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Category;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface ICategoryRepository {
    Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default);
    Task<bool> ExistsAsync(long id, bool includeDeleted, CancellationToken cancellationToken = default);
    Task<long> AddAsync(string name, CancellationToken cancellationToken = default);
    Task UpdateAsync(long id, string name, CancellationToken cancellationToken = default);
    Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default);
    Task<bool> MoveAsync(long id, string move, CancellationToken cancellationToken = default);
    Task MoveSortFirstAsync(long id, CancellationToken cancellationToken = default);
    Task MoveSortLastAsync(long id, CancellationToken cancellationToken = default);
    Task DeleteAsync(long id, int deleteType = 1, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<CategoryListItemDto>> GetAsync(CancellationToken cancellationToken = default);
    Task<PagedResult<CategoryListItemDto>> GetAsync(CategoryPageListQuery query, CancellationToken cancellationToken = default);
}
