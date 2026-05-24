namespace Mint.Blog.WebApi.Controllers.Blog.Admin.Uploads;

/// <summary>
///     文件上传表单。
/// </summary>
public sealed class UploadFileRequest {
	/// <summary>
	///     新上传的文件。
	/// </summary>
	public IFormFile NewFile { get; init; } = default!;

	/// <summary>
	///     文件原始名称。
	/// </summary>
	public string NewFileOriginalName { get; init; } = string.Empty;

	/// <summary>
	///     预留字段，保持与旧接口参数兼容。
	/// </summary>
	public string? OldFileName { get; init; }
}