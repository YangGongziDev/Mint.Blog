using Amazon.S3;
using Amazon.S3.Model;
using Microsoft.Extensions.Options;

namespace Mint.Blog.Common.Storage;

public sealed class RustFsObjectStorageQueryService(IAmazonS3 client, IOptions<RustFsOptions> options) : IObjectStorageQueryService {
    public string ResolveBucketName(string? bucketName) => string.IsNullOrWhiteSpace(bucketName) ? options.Value.BucketName : bucketName.Trim();
    public string BuildObjectUrl(string bucketName, string objectName) {
        var endpoint = string.IsNullOrWhiteSpace(options.Value.PublicEndpoint) ? options.Value.Endpoint : options.Value.PublicEndpoint;
        return $"{endpoint.TrimEnd('/')}/{bucketName}/{Uri.EscapeDataString(objectName).Replace("%2F", "/")}";
    }
    public async Task<IReadOnlyCollection<StorageObject>> ListAsync(string bucketName, CancellationToken cancellationToken = default) {
        var result = new List<StorageObject>();
        string? continuationToken = null;
        do {
            var response = await client.ListObjectsV2Async(new ListObjectsV2Request { BucketName = bucketName, ContinuationToken = continuationToken }, cancellationToken);
            foreach (var item in response.S3Objects) result.Add(new StorageObject(item.Key, item.Size, item.LastModified));
            continuationToken = response.IsTruncated ? response.NextContinuationToken : null;
        } while (!string.IsNullOrWhiteSpace(continuationToken));
        return result;
    }
}
