using System.Net;
using System.Text.Json;
using Amazon.S3;
using Amazon.S3.Model;
using Microsoft.Extensions.Options;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class RustFsBucketService(
	IAmazonS3 rustFsClient,
	IOptions<RustFsOptions> rustFsOptions) : IObjectStorageBucketService {
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
			var result = await rustFsClient.ListBucketsAsync(cancellationToken);
			var buckets = new List<ObjectStorageBucketDto>();
			foreach (var bucket in result.Buckets.OrderBy(item => item.BucketName)) {
				buckets.Add(new ObjectStorageBucketDto(bucket.BucketName, await IsBucketPublicAsync(bucket.BucketName, cancellationToken), bucket.CreationDate));
			}

			return buckets;
		} catch (AmazonS3Exception exception) {
			throw new BusinessException(ErrorCodes.FileUploadInvalid, $"图片存储服务暂时不可用，请检查 RustFS 服务、访问密钥或桶权限配置。{exception.Message}");
		}
	}

	public async Task CreateBucketAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default){
		var normalizedBucketName = NormalizeBucketName(bucketName);
		if (!await BucketExistsAsync(normalizedBucketName, cancellationToken)) {
			await rustFsClient.PutBucketAsync(new PutBucketRequest { BucketName = normalizedBucketName }, cancellationToken);
		}

		await SetBucketPublicAsync(normalizedBucketName, isPublic, cancellationToken);
	}

	public async Task SetBucketPublicAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default){
		var normalizedBucketName = NormalizeBucketName(bucketName);
		await EnsureBucketExistsAsync(normalizedBucketName, cancellationToken);

		await rustFsClient.PutBucketPolicyAsync(new PutBucketPolicyRequest {
			BucketName = normalizedBucketName,
			Policy = isPublic ? BuildPublicReadPolicy(normalizedBucketName) : BuildPrivatePolicy()
		}, cancellationToken);
	}

	public async Task DeleteBucketAsync(string bucketName, CancellationToken cancellationToken = default){
		var normalizedBucketName = NormalizeBucketName(bucketName);
		if (string.Equals(normalizedBucketName, rustFsOptions.Value.BucketName, StringComparison.OrdinalIgnoreCase))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "默认桶不能删除");

		await EnsureBucketExistsAsync(normalizedBucketName, cancellationToken);
		if (await BucketHasObjectsAsync(normalizedBucketName, cancellationToken))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶内还有文件，不能删除");

		await rustFsClient.DeleteBucketAsync(new DeleteBucketRequest { BucketName = normalizedBucketName }, cancellationToken);
	}

	private async Task<bool> BucketExistsAsync(string bucketName, CancellationToken cancellationToken){
		try {
			await rustFsClient.GetBucketLocationAsync(new GetBucketLocationRequest { BucketName = bucketName }, cancellationToken);
			return true;
		} catch (AmazonS3Exception exception) when (exception.StatusCode == HttpStatusCode.NotFound || exception.ErrorCode == "NoSuchBucket") {
			return false;
		}
	}

	private async Task<bool> BucketHasObjectsAsync(string bucketName, CancellationToken cancellationToken){
		var response = await rustFsClient.ListObjectsV2Async(new ListObjectsV2Request {
			BucketName = bucketName,
			MaxKeys = 1
		}, cancellationToken);

		return response.S3Objects.Count > 0;
	}

	private async Task<bool> IsBucketPublicAsync(string bucketName, CancellationToken cancellationToken){
		try {
			var response = await rustFsClient.GetBucketPolicyAsync(new GetBucketPolicyRequest { BucketName = bucketName }, cancellationToken);
			using var document = JsonDocument.Parse(response.Policy);
			if (!document.RootElement.TryGetProperty("Statement", out var statements) || statements.ValueKind != JsonValueKind.Array)
				return false;

			foreach (var statement in statements.EnumerateArray()) {
				if (!statement.TryGetProperty("Effect", out var effect) ||
				    !string.Equals(effect.GetString(), "Allow", StringComparison.OrdinalIgnoreCase)) continue;
				if (!statement.TryGetProperty("Action", out var action)) continue;
				if (PolicyActionContainsGetObject(action)) return true;
			}

			return false;
		} catch (AmazonS3Exception) {
			return false;
		}
	}

	private async Task EnsureBucketExistsAsync(string bucketName, CancellationToken cancellationToken){
		if (!await BucketExistsAsync(bucketName, cancellationToken))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "桶不存在");
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

	private static bool PolicyActionContainsGetObject(JsonElement action){
		return action.ValueKind switch {
			JsonValueKind.String => string.Equals(action.GetString(), "s3:GetObject", StringComparison.OrdinalIgnoreCase),
			JsonValueKind.Array => action.EnumerateArray().Any(item => string.Equals(item.GetString(), "s3:GetObject", StringComparison.OrdinalIgnoreCase)),
			_ => false
		};
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
