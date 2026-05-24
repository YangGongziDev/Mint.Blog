namespace Mint.Blog.Infrastructure.Options;

public sealed class MinioOptions {
	public const string SectionName = "Minio";

	public string Endpoint { get; set; } = string.Empty;
	public bool UseSsl { get; set; }
	public string PublicEndpoint { get; set; } = string.Empty;
	public string AccessKey { get; set; } = string.Empty;
	public string SecretKey { get; set; } = string.Empty;
	public string BucketName { get; set; } = string.Empty;
}