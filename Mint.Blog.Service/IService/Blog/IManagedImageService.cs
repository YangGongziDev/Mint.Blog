using Mint.Blog.Common.Storage;
using Mint.Blog.Model.Dtos.Blog.Upload;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Upload;

namespace Mint.Blog.Service.IService.Blog;

public interface IManagedImageService {
    Task<PagedResult<ManagedImageListItemDto>> GetAsync(ManagedImageListQuery query, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<ObjectStorageBucketDto>> GetBucketsAsync(CancellationToken cancellationToken = default);
    Task CreateBucketAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default);
    Task SetBucketPublicAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default);
    Task DeleteBucketAsync(string bucketName, CancellationToken cancellationToken = default);
}
