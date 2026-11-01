namespace Mint.Blog.Common.Storage;

public interface IObjectStorageQueryService {
    string ResolveBucketName(string? bucketName);
    string BuildObjectUrl(string bucketName, string objectName);
    Task<IReadOnlyCollection<StorageObject>> ListAsync(string bucketName, CancellationToken cancellationToken = default);
}

public sealed record StorageObject(string ObjectName, long Size, DateTime? LastModified);
