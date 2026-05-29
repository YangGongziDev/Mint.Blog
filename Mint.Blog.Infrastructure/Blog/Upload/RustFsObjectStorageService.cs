using System.Net;
using Amazon.S3;
using Amazon.S3.Model;
using Microsoft.Extensions.Options;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class RustFsObjectStorageService(
	IAmazonS3 rustFsClient,
	IOptions<RustFsOptions> rustFsOptions) : IObjectStorageService {
	public Task<string> UploadAsync(Stream stream, long length, string fileName, string? contentType,
		CancellationToken cancellationToken = default){
		return UploadAsync(stream, length, fileName, contentType, null, cancellationToken);
	}

	public async Task<string> UploadAsync(Stream stream, long length, string fileName, string? contentType, string? bucketName,
		CancellationToken cancellationToken = default){
		var targetBucketName = ResolveBucketName(bucketName);
		await EnsureBucketExistsAsync(targetBucketName, cancellationToken);
		var objectName = BuildObjectName(fileName);

		await rustFsClient.PutObjectAsync(new PutObjectRequest {
			BucketName = targetBucketName,
			Key = objectName,
			InputStream = stream,
			ContentType = contentType ?? "application/octet-stream"
		}, cancellationToken);

		return BuildObjectUrl(targetBucketName, objectName);
	}

	public async Task DeleteAsync(string objectName, CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(objectName) || !TryNormalizeManagedObjectName(objectName, out var bucketName, out var normalizedObjectName))
			return;

		if (!await ExistsAsync(bucketName, normalizedObjectName, cancellationToken)) return;

		await rustFsClient.DeleteObjectAsync(new DeleteObjectRequest {
			BucketName = bucketName,
			Key = normalizedObjectName
		}, cancellationToken);
	}

	public async Task DeleteManyAsync(IReadOnlyCollection<string> objectNames,
		CancellationToken cancellationToken = default){
		foreach (var objectName in objectNames) await DeleteAsync(objectName, cancellationToken);
	}

	public async Task<RenamedObjectResult> RenameAsync(string oldObjectName, string newObjectName,
		CancellationToken cancellationToken = default){
		if (!TryNormalizeManagedObjectName(oldObjectName, out var bucketName, out var normalizedOldObjectName))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "旧图片名称不能为空");

		var oldUrl = BuildObjectUrl(bucketName, normalizedOldObjectName);
		var normalizedNewObjectName = BuildRenameObjectName(normalizedOldObjectName, newObjectName);
		var newUrl = BuildObjectUrl(bucketName, normalizedNewObjectName);
		if (string.Equals(normalizedOldObjectName, normalizedNewObjectName, StringComparison.Ordinal))
			return new RenamedObjectResult(oldUrl, newUrl);

		if (!await ExistsAsync(bucketName, normalizedOldObjectName, cancellationToken))
			throw new BusinessException(ErrorCodes.ArticleNotFound, "图片不存在");

		if (await ExistsAsync(bucketName, normalizedNewObjectName, cancellationToken))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "目标图片名称已存在");

		await rustFsClient.CopyObjectAsync(new CopyObjectRequest {
			SourceBucket = bucketName,
			SourceKey = normalizedOldObjectName,
			DestinationBucket = bucketName,
			DestinationKey = normalizedNewObjectName
		}, cancellationToken);
		await DeleteAsync(oldUrl, cancellationToken);

		return new RenamedObjectResult(oldUrl, newUrl);
	}

	public async Task<IReadOnlyCollection<ObjectMoveConflict>> GetMoveConflictsAsync(IReadOnlyCollection<string> objectNames,
		string targetBucketName, CancellationToken cancellationToken = default){
		var normalizedTargetBucketName = ResolveBucketName(targetBucketName);
		await EnsureBucketExistsAsync(normalizedTargetBucketName, cancellationToken);

		var conflicts = new List<ObjectMoveConflict>();
		foreach (var objectName in objectNames.Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase)) {
			if (!TryNormalizeManagedObjectName(objectName, out var sourceBucketName, out var normalizedObjectName)) continue;
			if (string.Equals(sourceBucketName, normalizedTargetBucketName, StringComparison.OrdinalIgnoreCase)) continue;
			if (!await ExistsAsync(normalizedTargetBucketName, normalizedObjectName, cancellationToken)) continue;

			conflicts.Add(new ObjectMoveConflict(
				BuildObjectUrl(sourceBucketName, normalizedObjectName),
				sourceBucketName,
				normalizedObjectName,
				normalizedTargetBucketName,
				normalizedObjectName,
				BuildObjectUrl(normalizedTargetBucketName, normalizedObjectName),
				true));
		}

		return conflicts;
	}

	public async Task<RenamedObjectResult> MoveToBucketAsync(string oldObjectName, string targetBucketName,
		bool overwriteExisting = false, CancellationToken cancellationToken = default){
		if (!TryNormalizeManagedObjectName(oldObjectName, out var sourceBucketName, out var normalizedOldObjectName))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "旧图片名称不能为空");

		var normalizedTargetBucketName = ResolveBucketName(targetBucketName);
		await EnsureBucketExistsAsync(sourceBucketName, cancellationToken);
		await EnsureBucketExistsAsync(normalizedTargetBucketName, cancellationToken);

		if (string.Equals(sourceBucketName, normalizedTargetBucketName, StringComparison.OrdinalIgnoreCase))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "目标桶不能和当前桶相同");

		var oldUrl = BuildObjectUrl(sourceBucketName, normalizedOldObjectName);
		var newUrl = BuildObjectUrl(normalizedTargetBucketName, normalizedOldObjectName);

		if (!await ExistsAsync(sourceBucketName, normalizedOldObjectName, cancellationToken))
			throw new BusinessException(ErrorCodes.ArticleNotFound, "图片不存在");

		if (await ExistsAsync(normalizedTargetBucketName, normalizedOldObjectName, cancellationToken)) {
			if (!overwriteExisting) throw new BusinessException(ErrorCodes.FileUploadInvalid, "目标桶中已存在同名图片");
			await DeleteAsync(BuildObjectUrl(normalizedTargetBucketName, normalizedOldObjectName), cancellationToken);
		}

		await rustFsClient.CopyObjectAsync(new CopyObjectRequest {
			SourceBucket = sourceBucketName,
			SourceKey = normalizedOldObjectName,
			DestinationBucket = normalizedTargetBucketName,
			DestinationKey = normalizedOldObjectName
		}, cancellationToken);

		await rustFsClient.DeleteObjectAsync(new DeleteObjectRequest {
			BucketName = sourceBucketName,
			Key = normalizedOldObjectName
		}, cancellationToken);

		return new RenamedObjectResult(oldUrl, newUrl);
	}

	private async Task<bool> ExistsAsync(string bucketName, string objectName, CancellationToken cancellationToken){
		try {
			await rustFsClient.GetObjectMetadataAsync(new GetObjectMetadataRequest {
				BucketName = bucketName,
				Key = objectName
			}, cancellationToken);
			return true;
		} catch (AmazonS3Exception exception) when (exception.StatusCode == HttpStatusCode.NotFound || exception.ErrorCode == "NoSuchKey") {
			return false;
		}
	}

	private bool TryNormalizeManagedObjectName(string objectName, out string normalizedObjectName){
		var result = TryNormalizeManagedObjectName(objectName, out _, out normalizedObjectName);
		return result;
	}

	private bool TryNormalizeManagedObjectName(string objectName, out string bucketName, out string normalizedObjectName){
		bucketName = rustFsOptions.Value.BucketName.Trim('/');
		normalizedObjectName = string.Empty;
		var trimmedObjectName = objectName.Trim();
		if (Uri.TryCreate(trimmedObjectName, UriKind.Absolute, out var uri)) {
			var pathSegments = uri.AbsolutePath
				.Split('/', StringSplitOptions.RemoveEmptyEntries)
				.Select(Uri.UnescapeDataString)
				.ToArray();
			if (pathSegments.Length < 2) return false;

			bucketName = pathSegments[0];
			normalizedObjectName = string.Join('/', pathSegments.Skip(1));
			return !string.IsNullOrWhiteSpace(bucketName) && !string.IsNullOrWhiteSpace(normalizedObjectName);
		}

		normalizedObjectName = trimmedObjectName;
		return !string.IsNullOrWhiteSpace(normalizedObjectName);
	}

	private string BuildObjectUrl(string objectName){
		return BuildObjectUrl(rustFsOptions.Value.BucketName, objectName);
	}

	private string BuildObjectUrl(string bucketName, string objectName){
		var publicEndpoint = string.IsNullOrWhiteSpace(rustFsOptions.Value.PublicEndpoint)
			? rustFsOptions.Value.Endpoint
			: rustFsOptions.Value.PublicEndpoint;

		return $"{publicEndpoint.TrimEnd('/')}/{bucketName}/{Uri.EscapeDataString(objectName).Replace("%2F", "/")}";
	}

	private string ResolveBucketName(string? bucketName){
		var targetBucketName = string.IsNullOrWhiteSpace(bucketName) ? rustFsOptions.Value.BucketName : bucketName.Trim();
		if (string.IsNullOrWhiteSpace(targetBucketName))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶名称不能为空");

		return targetBucketName;
	}

	private async Task EnsureBucketExistsAsync(string bucketName, CancellationToken cancellationToken){
		try {
			await rustFsClient.GetBucketLocationAsync(new GetBucketLocationRequest { BucketName = bucketName }, cancellationToken);
		} catch (AmazonS3Exception exception) when (exception.StatusCode == HttpStatusCode.NotFound || exception.ErrorCode == "NoSuchBucket") {
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶不存在");
		}
	}

	private static string BuildRenameObjectName(string oldObjectName, string newObjectName){
		var sanitizedNewName = WebUtility.UrlDecode(newObjectName.Trim()).Replace('\\', '/').Trim('/');
		if (string.IsNullOrWhiteSpace(sanitizedNewName))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "新图片名称不能为空");

		if (sanitizedNewName.Contains("..", StringComparison.Ordinal))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "新图片名称不合法");

		var oldDirectory = Path.GetDirectoryName(oldObjectName)?.Replace('\\', '/');
		var oldExtension = Path.GetExtension(oldObjectName);
		var newExtension = Path.GetExtension(sanitizedNewName);
		var fileName = string.IsNullOrWhiteSpace(newExtension) && !string.IsNullOrWhiteSpace(oldExtension)
			? $"{sanitizedNewName}{oldExtension}"
			: sanitizedNewName;

		return fileName.Contains('/') || string.IsNullOrWhiteSpace(oldDirectory) ? fileName : $"{oldDirectory}/{fileName}";
	}

	private static string BuildObjectName(string fileName){
		var sanitizedFileName = WebUtility.UrlDecode(fileName.Trim()).Replace('\\', '/').Trim('/');
		if (string.IsNullOrWhiteSpace(sanitizedFileName))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "图片名称不能为空");

		if (sanitizedFileName.Contains("..", StringComparison.Ordinal))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "图片名称不合法");

		return sanitizedFileName;
	}
}
