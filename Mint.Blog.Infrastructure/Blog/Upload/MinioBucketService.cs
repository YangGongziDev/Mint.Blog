using System.Text.Json;
using Microsoft.Extensions.Options;
using Minio;
using Minio.DataModel.Args;
using Minio.Exceptions;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class MinioBucketService(
	IMinioClient minioClient,
	IOptions<MinioOptions> minioOptions) : IObjectStorageBucketService {
	private const string BucketNamePlaceholder = "__BUCKET_NAME__";

	private const string PublicReadPolicyTemplate = """
	{
	  "Version": "2012-10-17",
	  "Statement": [
	    {
	      "Effect": "Allow",
	      "Principal": { "AWS": ["*"] },
	      "Action": ["s3:GetBucketLocation", "s3:ListBucket"],
	      "Resource": ["arn:aws:s3:::__BUCKET_NAME__"]
	    },
	    {
	      "Effect": "Allow",
	      "Principal": { "AWS": ["*"] },
	      "Action": ["s3:GetObject"],
	      "Resource": ["arn:aws:s3:::__BUCKET_NAME__/*"]
	    }
	  ]
	}
	""";

	public async Task<IReadOnlyCollection<ObjectStorageBucketDto>> GetBucketsAsync(CancellationToken cancellationToken = default){
		try {
			var result = await minioClient.ListBucketsAsync(cancellationToken);
			var buckets = new List<ObjectStorageBucketDto>();
			foreach (var bucket in result.Buckets.OrderBy(item => item.Name)) {
				buckets.Add(new ObjectStorageBucketDto(bucket.Name, await IsBucketPublicAsync(bucket.Name, cancellationToken), bucket.CreationDateDateTime));
			}

			return buckets;
		} catch (MinioException exception) {
			throw new BusinessException(ErrorCodes.FileUploadInvalid, $"图片存储服务暂时不可用，请检查 MinIO 服务、访问密钥或桶权限配置。{exception.Message}");
		}
	}

	public async Task CreateBucketAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default){
		var normalizedBucketName = NormalizeBucketName(bucketName);
		var exists = await minioClient.BucketExistsAsync(new BucketExistsArgs().WithBucket(normalizedBucketName), cancellationToken);
		if (!exists) {
			await minioClient.MakeBucketAsync(new MakeBucketArgs().WithBucket(normalizedBucketName), cancellationToken);
		}

		await SetBucketPublicAsync(normalizedBucketName, isPublic, cancellationToken);
	}

	public async Task SetBucketPublicAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default){
		var normalizedBucketName = NormalizeBucketName(bucketName);
		await EnsureBucketExistsAsync(normalizedBucketName, cancellationToken);

		if (isPublic) {
			await minioClient.SetPolicyAsync(new SetPolicyArgs()
				.WithBucket(normalizedBucketName)
				.WithPolicy(BuildPublicReadPolicy(normalizedBucketName)), cancellationToken);
			return;
		}

		try {
			await minioClient.SetPolicyAsync(new SetPolicyArgs()
				.WithBucket(normalizedBucketName)
				.WithPolicy(BuildPrivatePolicy()), cancellationToken);
		} catch (MinioException) {
			await minioClient.SetPolicyAsync(new SetPolicyArgs()
				.WithBucket(normalizedBucketName)
				.WithPolicy(BuildPrivatePolicy()), cancellationToken);
		}
	}

	public async Task DeleteBucketAsync(string bucketName, CancellationToken cancellationToken = default){
		var normalizedBucketName = NormalizeBucketName(bucketName);
		if (string.Equals(normalizedBucketName, minioOptions.Value.BucketName, StringComparison.OrdinalIgnoreCase))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "默认桶不能删除");

		await EnsureBucketExistsAsync(normalizedBucketName, cancellationToken);
		if (await BucketHasObjectsAsync(normalizedBucketName, cancellationToken))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶内还有文件，不能删除");

		await minioClient.RemoveBucketAsync(new RemoveBucketArgs().WithBucket(normalizedBucketName), cancellationToken);
	}

	private async Task<bool> BucketHasObjectsAsync(string bucketName, CancellationToken cancellationToken){
		await foreach (var _ in minioClient.ListObjectsEnumAsync(new ListObjectsArgs()
			               .WithBucket(bucketName)
			               .WithRecursive(true), cancellationToken)) {
			return true;
		}

		return false;
	}

	private async Task<bool> IsBucketPublicAsync(string bucketName, CancellationToken cancellationToken){
		try {
			var policy = await minioClient.GetPolicyAsync(new GetPolicyArgs().WithBucket(bucketName), cancellationToken);
			using var document = JsonDocument.Parse(policy);
			if (!document.RootElement.TryGetProperty("Statement", out var statements) || statements.ValueKind != JsonValueKind.Array)
				return false;

			foreach (var statement in statements.EnumerateArray()) {
				if (!statement.TryGetProperty("Effect", out var effect) ||
				    !string.Equals(effect.GetString(), "Allow", StringComparison.OrdinalIgnoreCase)) continue;
				if (!statement.TryGetProperty("Action", out var action) || action.ValueKind != JsonValueKind.Array) continue;
				if (action.EnumerateArray().Any(item => string.Equals(item.GetString(), "s3:GetObject", StringComparison.OrdinalIgnoreCase)))
					return true;
			}

			return false;
		} catch (MinioException) {
			return false;
		}
	}

	private async Task EnsureBucketExistsAsync(string bucketName, CancellationToken cancellationToken){
		var exists = await minioClient.BucketExistsAsync(new BucketExistsArgs().WithBucket(bucketName), cancellationToken);
		if (!exists) throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶不存在");
	}

	private static string NormalizeBucketName(string bucketName){
		var normalizedBucketName = bucketName.Trim().ToLowerInvariant();
		if (string.IsNullOrWhiteSpace(normalizedBucketName))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶名称不能为空");

		if (normalizedBucketName.Length is < 3 or > 63 || normalizedBucketName.Contains("..", StringComparison.Ordinal) ||
		    normalizedBucketName.StartsWith('.') || normalizedBucketName.EndsWith('.') ||
		    !normalizedBucketName.All(ch => char.IsLower(ch) || char.IsDigit(ch) || ch is '-' or '.'))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶名称不合法，请使用 3-63 位小写字母、数字、短横线或点");

		return normalizedBucketName;
	}

	private static string BuildPublicReadPolicy(string bucketName){
		return PublicReadPolicyTemplate.Replace(BucketNamePlaceholder, bucketName, StringComparison.Ordinal);
	}

	private static string BuildPrivatePolicy(){
		return """
		{
		  "Version": "2012-10-17",
		  "Statement": []
		}
		""";
	}
}
