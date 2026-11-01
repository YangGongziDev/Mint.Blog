using Mint.Blog.Model.Dtos.Blog.Tag;
using Mint.Blog.Model.Entitys.Blog.Tag;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Tag;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface ITagRepository {
    Task<IReadOnlyCollection<TagListItemDto>> GetAsync(CancellationToken ct = default);
    Task<PagedResult<TagListItemDto>> GetAsync(TagPageListQuery query, CancellationToken ct = default);
    Task<IReadOnlyCollection<long>> FilterExistingIdsAsync(IEnumerable<long> ids, CancellationToken ct = default);
    Task<bool> ExistsAsync(long id, CancellationToken ct = default);
    Task<bool> ExistsAsync(long id, bool includeDeleted, CancellationToken ct = default);
    Task<TagDataModel?> GetSnapshotAsync(long id, CancellationToken ct);
    Task<IReadOnlyCollection<long>> LockCategorySnapshotAsync(long id, CancellationToken ct);
    Task<bool> NameExistsAsync(string name, long excludingId, CancellationToken ct);
    Task<bool> HasValidCategoryAsync(long id, CancellationToken ct);
    Task<long> AddAsync(string name, long categoryId, string logoUrl, CancellationToken ct = default);
    Task UpdateAsync(long id, string name, long categoryId, string? logoUrl, CancellationToken ct = default);
    Task UpdateSortAsync(long id, int sort, CancellationToken ct = default);
    Task MoveSortFirstAsync(long id, CancellationToken ct = default);
    Task MoveSortLastAsync(long id, CancellationToken ct = default);
    Task DeleteAsync(long id, int deleteType = 1, CancellationToken ct = default);
}
