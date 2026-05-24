namespace Mint.Blog.Application.Abstractions;

public interface IObjectStorageService {
	Task<string> UploadAsync(Stream stream, long length, string fileName, string? contentType,
		CancellationToken cancellationToken = default);
	Task<string> UploadAsync(Stream stream, long length, string fileName, string? contentType, string? bucketName,
		CancellationToken cancellationToken = default);

	Task DeleteAsync(string objectName, CancellationToken cancellationToken = default);
	Task DeleteManyAsync(IReadOnlyCollection<string> objectNames, CancellationToken cancellationToken = default);
	Task<RenamedObjectResult> RenameAsync(string oldObjectName, string newObjectName, CancellationToken cancellationToken = default);
	Task<IReadOnlyCollection<ObjectMoveConflict>> GetMoveConflictsAsync(IReadOnlyCollection<string> objectNames, string targetBucketName,
		CancellationToken cancellationToken = default);
	Task<RenamedObjectResult> MoveToBucketAsync(string oldObjectName, string targetBucketName, bool overwriteExisting = false,
		CancellationToken cancellationToken = default);
}