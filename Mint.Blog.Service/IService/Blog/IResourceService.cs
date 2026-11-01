using Mint.Blog.Model.Dtos.Blog.Resource;
using Mint.Blog.Model.Vos.Blog.Resource;
using Mint.Blog.Model.Vos;

namespace Mint.Blog.Service.IService.Blog;

public interface IResourceService {
    Task<long> ConfigureNavigationAsync(long tagId, ConfigureNavigationTagCommand command, CancellationToken ct);
    Task<long> SaveVersionAsync(long tagId, long? versionId, SaveTagVersionCommand command, CancellationToken ct);
    Task<long> DeleteVersionAsync(long tagId, long versionId, CancellationToken ct);
    Task<long> SaveResourceAsync(long? id, SaveResourceCommand command, CancellationToken ct);
    Task<long> DeleteResourceAsync(long id, CancellationToken ct);
    Task<long> RestoreResourceAsync(long id, CancellationToken ct);
    Task<PagedResult<NavigationArticleDto>> GetArticlesAsync(long tagId, NavigationArticleQuery query, CancellationToken ct);
    Task<IReadOnlyCollection<NavigationTagDto>> GetNavigationTagsAsync(bool publicOnly, long? categoryId, string? keyword, CancellationToken ct);
    Task<IReadOnlyCollection<TagVersionDto>> GetVersionsAsync(long tagId, bool publicOnly, CancellationToken ct);
    Task<PagedResult<ResourceDto>> GetResourcesAsync(ResourcePageQuery query, bool publicOnly, CancellationToken ct);
    Task<ResourceDto> GetResourceAsync(long id, CancellationToken ct);
}
