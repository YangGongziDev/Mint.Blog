using System.Net;
using Microsoft.Extensions.Options;
using Minio;
using Minio.DataModel.Args;
using Minio.Exceptions;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class MinioObjectStorageService(
	IMinioClient minioClient,
	IOptions<MinioOptions> minioOptions) : IObjectStorageService {
	public Task<string> UploadAsync(Stream stream, long length, string fileName, string? contentType,
		CancellationToken cancellationToken = default){
		return UploadAsync(stream, length, fileName, contentType, null, cancellationToken);
	}

	public async Task<string> UploadAsync(Stream stream, long length, string fileName, string? contentType, string? bucketName,
		CancellationToken cancellationToken = default){
		var targetBucketName = ResolveBucketName(bucketName);
		await EnsureBucketExistsAsync(targetBucketName, cancellationToken);
		var objectName = BuildObjectName(fileName);

		await minioClient.PutObjectAsync(new PutObjectArgs()
			.WithBucket(targetBucketName)
			.WithObject(objectName)
			.WithStreamData(stream)
			.WithObjectSize(length)
			.WithContentType(contentType ?? "application/octet-stream"), cancellationToken);

		return BuildObjectUrl(targetBucketName, objectName);
	}

	public async Task DeleteAsync(string objectName, CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(objectName) || !TryNormalizeManagedObjectName(objectName, out var bucketName, out var normalizedObjectName))
			return;

		if (!await ExistsAsync(bucketName, normalizedObjectName, cancellationToken)) return;

		await minioClient.RemoveObjectAsync(new RemoveObjectArgs()
			.WithBucket(bucketName)
			.WithObject(normalizedObjectName), cancellationToken);
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

		await minioClient.CopyObjectAsync(new CopyObjectArgs()
			.WithBucket(bucketName)
			.WithObject(normalizedNewObjectName)
			.WithCopyObjectSource(new CopySourceObjectArgs()
				.WithBucket(bucketName)
				.WithObject(normalizedOldObjectName)), cancellationToken);
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

		await minioClient.CopyObjectAsync(new CopyObjectArgs()
			.WithBucket(normalizedTargetBucketName)
			.WithObject(normalizedOldObjectName)
			.WithCopyObjectSource(new CopySourceObjectArgs()
				.WithBucket(sourceBucketName)
				.WithObject(normalizedOldObjectName)), cancellationToken);

		await minioClient.RemoveObjectAsync(new RemoveObjectArgs()
			.WithBucket(sourceBucketName)
			.WithObject(normalizedOldObjectName), cancellationToken);

		return new RenamedObjectResult(oldUrl, newUrl);
	}

	private async Task<bool> ExistsAsync(string bucketName, string objectName, CancellationToken cancellationToken){
		try {
			await minioClient.StatObjectAsync(new StatObjectArgs()
				.WithBucket(bucketName)
				.WithObject(objectName), cancellationToken);
			return true;
		} catch (ObjectNotFoundException) {
			return false;
		}
	}

	private bool TryNormalizeManagedObjectName(string objectName, out string normalizedObjectName){
		var result = TryNormalizeManagedObjectName(objectName, out _, out normalizedObjectName);
		return result;
	}

	private bool TryNormalizeManagedObjectName(string objectName, out string bucketName, out string normalizedObjectName){
		bucketName = minioOptions.Value.BucketName.Trim('/');
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
		return BuildObjectUrl(minioOptions.Value.BucketName, objectName);
	}

	private string BuildObjectUrl(string bucketName, string objectName){
		var publicEndpoint = string.IsNullOrWhiteSpace(minioOptions.Value.PublicEndpoint)
			? minioOptions.Value.Endpoint
			: minioOptions.Value.PublicEndpoint;

		return $"{publicEndpoint.TrimEnd('/')}/{bucketName}/{Uri.EscapeDataString(objectName).Replace("%2F", "/")}";
	}

	private string ResolveBucketName(string? bucketName){
		var targetBucketName = string.IsNullOrWhiteSpace(bucketName) ? minioOptions.Value.BucketName : bucketName.Trim();
		if (string.IsNullOrWhiteSpace(targetBucketName))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶名称不能为空");

		return targetBucketName;
	}

	private async Task EnsureBucketExistsAsync(string bucketName, CancellationToken cancellationToken){
		var exists = await minioClient.BucketExistsAsync(new BucketExistsArgs().WithBucket(bucketName), cancellationToken);
		if (!exists) throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶不存在");
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
