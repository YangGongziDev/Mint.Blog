using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Upload.Commands.DeleteFile;
using Mint.Blog.Application.Blog.Upload.Commands.UploadFile;
using Mint.Blog.WebApi.Controllers.Blog.Admin.Uploads;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

/// <summary>
///     后台文件上传接口。
/// </summary>
[ApiController]
[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
[Route("api/blog/admin/file")]
public sealed class FileController(
	UploadFileCommandHandler uploadFileCommandHandler,
	DeleteFileCommandHandler deleteFileCommandHandler) : ControllerBase {
	/// <summary>
	///     上传普通文件并返回可访问地址。
	/// </summary>
	/// <param name="request">上传表单，包含文件本体和原始文件名。</param>
	/// <param name="cancellationToken">请求取消令牌。</param>
	[HttpPost("upload")]
	[Consumes("multipart/form-data")]
	[ProducesResponseType(typeof(ApiResponse<UploadResult>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<UploadResult>>> Upload(
		[FromForm] UploadFileRequest request,
		CancellationToken cancellationToken){
		await using var stream = request.NewFile.OpenReadStream();
		var url = await uploadFileCommandHandler.HandleAsync(
			new UploadFileCommand(stream, request.NewFile.Length, request.NewFileOriginalName,
				request.NewFile.ContentType, request.OldFileName),
			cancellationToken);

		return Ok(ApiResponse<UploadResult>.Ok(new UploadResult(url)));
	}

	/// <summary>
	///     删除普通文件。
	/// </summary>
	/// <param name="oldFileName">旧文件对象名或完整访问地址。</param>
	/// <param name="cancellationToken">请求取消令牌。</param>
	[HttpPost("delete")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete([FromBody] string? oldFileName,
		CancellationToken cancellationToken){
		await deleteFileCommandHandler.HandleAsync(new DeleteFileCommand(oldFileName), cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}
}