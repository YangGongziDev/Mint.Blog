using Mint.Blog.Model.Entitys.Blog.Resource;
using Mint.Blog.Model.Dtos.Blog.Resource;
using Mint.Blog.Model.Vos.Blog.Resource;
using Mint.Blog.Model.Vos;
using ResourceEntity = Mint.Blog.Model.Entitys.Blog.Resource.Resource;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IResourceRepository {
    Task<bool> LockTagAsync(long id, CancellationToken ct, bool includeDeleted = false);
    Task<bool> LockCategoryAsync(long id, CancellationToken ct, bool includeDeleted = false);
    Task LockTagsAsync(IEnumerable<long> ids, CancellationToken ct, bool includeDeleted = false);
    Task<bool> TagHasNavigationDataAsync(long tagId, CancellationToken ct);
    Task<bool> CategoryHasTagsAsync(long categoryId, bool includeDeleted, CancellationToken ct);
    Task<ResourceEntity?> GetResourceAsync(long id, bool forUpdate, CancellationToken ct, bool includeDeleted = false);
    Task<TagVersion?> GetVersionAsync(long tagId, long id, bool forUpdate, CancellationToken ct);
    Task<bool> VersionNameExistsAsync(long tagId, string name, long excludingId, CancellationToken ct);
    Task<bool> ResourceUrlExistsAsync(long tagId, long tagVersionId, string url, long excludingId, CancellationToken ct);
    Task<bool> VersionReferencedAsync(long id, CancellationToken ct);
    Task<long> SaveVersionAsync(TagVersion version, CancellationToken ct);
    Task<long> SaveResourceAsync(ResourceEntity resource, CancellationToken ct);
    Task UpdateNavigationAsync(long tagId, bool enabled, string description, CancellationToken ct);
    Task<PagedResult<NavigationArticleDto>> GetArticlesAsync(long tagId, NavigationArticleQuery query, CancellationToken ct);
    Task<IReadOnlyCollection<NavigationTagDto>> GetNavigationTagsAsync(bool publicOnly, long? categoryId, string? keyword, CancellationToken ct);
    Task<bool> TagAvailableAsync(long tagId, bool publicOnly, CancellationToken ct);
    Task<bool> VersionAvailableAsync(long tagId, long versionId, CancellationToken ct);
    Task<IReadOnlyCollection<TagVersionDto>> GetVersionsAsync(long tagId, CancellationToken ct);
    Task<PagedResult<ResourceDto>> GetResourcesAsync(ResourcePageQuery query, bool publicOnly, CancellationToken ct);
    Task<ResourceDto?> GetResourceAsync(long id, CancellationToken ct);
}
