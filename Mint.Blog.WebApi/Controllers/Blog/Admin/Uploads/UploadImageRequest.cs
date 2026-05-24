namespace Mint.Blog.WebApi.Controllers.Blog.Admin.Uploads;

/// <summary>
///     图片上传表单。
/// </summary>
public sealed class UploadImageRequest {
	/// <summary>
	///     新上传的图片文件。
	/// </summary>
	public IFormFile NewImageFile { get; init; } = default!;

	/// <summary>
	///     图片原始文件名。
	/// </summary>
	public string NewImageOriginalName { get; init; } = string.Empty;

	/// <summary>
	///     目标桶名称，不传则使用默认桶。
	/// </summary>
	public string? BucketName { get; init; }

	/// <summary>
	///     需要被替换的旧图片对象名或完整访问地址。
	/// </summary>
	public string? OldImageName { get; init; }
}