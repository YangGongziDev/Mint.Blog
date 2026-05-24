namespace Mint.Blog.Application.Abstractions;

public interface IObjectStorageBucketService {
	Task<IReadOnlyCollection<ObjectStorageBucketDto>> GetBucketsAsync(CancellationToken cancellationToken = default);
	Task CreateBucketAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default);
	Task SetBucketPublicAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default);
	Task DeleteBucketAsync(string bucketName, CancellationToken cancellationToken = default);
}

public sealed record ObjectStorageBucketDto(string Name, bool IsPublic, DateTime? CreationDate);
