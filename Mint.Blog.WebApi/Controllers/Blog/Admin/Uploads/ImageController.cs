using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Upload.Commands.DeleteImage;
using Mint.Blog.Application.Blog.Upload.Commands.DeleteImages;
using Mint.Blog.Application.Blog.Upload.Commands.MoveImage;
using Mint.Blog.Application.Blog.Upload.Commands.MoveImages;
using Mint.Blog.Application.Blog.Upload.Commands.RenameImage;
using Mint.Blog.Application.Blog.Upload.Commands.UploadImage;
using Mint.Blog.Application.Blog.Upload.Images;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin.Uploads;

/// <summary>
///     后台图片上传与删除接口。
/// </summary>
[ApiController]
[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
[Route("api/blog/admin/image")]
public sealed class ImageController(
	UploadImageCommandHandler uploadImageCommandHandler,
	DeleteImageCommandHandler deleteImageCommandHandler,
	DeleteImagesCommandHandler deleteImagesCommandHandler,
	RenameImageCommandHandler renameImageCommandHandler,
	MoveImageCommandHandler moveImageCommandHandler,
	MoveImagesCommandHandler moveImagesCommandHandler,
	IManagedImageQueryService managedImageQueryService,
	IObjectStorageBucketService bucketService) : ControllerBase {
	[HttpGet("buckets")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<ObjectStorageBucketDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<ObjectStorageBucketDto>>>> GetBuckets(
		CancellationToken cancellationToken){
		var buckets = await bucketService.GetBucketsAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<ObjectStorageBucketDto>>.Ok(buckets));
	}

	[HttpPost("buckets")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> CreateBucket([FromBody] CreateBucketRequest request,
		CancellationToken cancellationToken){
		await bucketService.CreateBucketAsync(request.BucketName, request.IsPublic, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}

	[HttpPatch("buckets/{bucketName}/public")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> SetBucketPublic(string bucketName,
		[FromBody] SetBucketPublicRequest request, CancellationToken cancellationToken){
		await bucketService.SetBucketPublicAsync(bucketName, request.IsPublic, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}

	[HttpDelete("buckets/{bucketName}")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> DeleteBucket(string bucketName,
		CancellationToken cancellationToken){
		await bucketService.DeleteBucketAsync(bucketName, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}
	/// <summary>
	///     分页查询 MinIO 图片及文章引用信息。
	/// </summary>
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<ManagedImageListItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<PagedResult<ManagedImageListItemDto>>>> GetList(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 20,
		[FromQuery] string? bucketName = null,
		[FromQuery] string? fileName = null,
		[FromQuery] bool? used = null,
		CancellationToken cancellationToken = default){
		var result = await managedImageQueryService.GetAsync(
			new ManagedImageListQuery(pageNumber, pageSize, bucketName, fileName, used), cancellationToken);
		return Ok(ApiResponse<PagedResult<ManagedImageListItemDto>>.Ok(result));
	}
	/// <summary>
	///     上传图片并返回可访问地址。
	/// </summary>
	/// <param name="request">上传表单，包含图片文件、原始文件名和可选旧图片标识。</param>
	/// <param name="cancellationToken">请求取消令牌。</param>
	[HttpPost("upload")]
	[Consumes("multipart/form-data")]
	[ProducesResponseType(typeof(ApiResponse<UploadResult>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<UploadResult>>> Upload(
		[FromForm] UploadImageRequest request,
		CancellationToken cancellationToken){
		await using var stream = request.NewImageFile.OpenReadStream();
		var url = await uploadImageCommandHandler.HandleAsync(
			new UploadImageCommand(stream, request.NewImageFile.Length, request.NewImageOriginalName,
				request.NewImageFile.ContentType, request.OldImageName, request.BucketName),
			cancellationToken);

		return Ok(ApiResponse<UploadResult>.Ok(new UploadResult(url)));
	}

	/// <summary>
	///     删除单张图片。
	/// </summary>
	/// <param name="oldImageName">旧图片对象名或完整访问地址。</param>
	/// <param name="cancellationToken">请求取消令牌。</param>
	[HttpPost("delete")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete([FromBody] string? oldImageName,
		CancellationToken cancellationToken){
		await deleteImageCommandHandler.HandleAsync(new DeleteImageCommand(oldImageName), cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}

	/// <summary>
	///     批量删除图片。
	/// </summary>
	/// <param name="oldImageNames">待删除的图片对象名或完整访问地址列表。</param>
	/// <param name="cancellationToken">请求取消令牌。</param>
	[HttpPost("delete-many")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> DeleteMany(
		[FromBody] IReadOnlyCollection<string> oldImageNames, CancellationToken cancellationToken){
		var result = await deleteImagesCommandHandler.HandleAsync(new DeleteImagesCommand(oldImageNames), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { deletedCount = result.DeletedCount, skippedUsedCount = result.SkippedUsedCount }));
	}

	/// <summary>
	///     重命名图片对象。
	/// </summary>
	[HttpPost("rename")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Rename([FromBody] RenameImageCommand command,
		CancellationToken cancellationToken){
		var url = await renameImageCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { url }));
	}

	/// <summary>
	///     移动图片对象到其他桶。
	/// </summary>
	[HttpPost("move")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Move([FromBody] MoveImageCommand command,
		CancellationToken cancellationToken){
		var url = await moveImageCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { url }));
	}

	/// <summary>
	///     预检查批量移动图片时目标桶中的同名冲突。
	/// </summary>
	[HttpPost("move-many/precheck")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveManyPrecheck([FromBody] MoveImagesPrecheckCommand command,
		CancellationToken cancellationToken){
		var result = await moveImagesCommandHandler.PrecheckAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { conflicts = result.Conflicts }));
	}

	/// <summary>
	///     批量移动图片对象到其他桶。
	/// </summary>
	[HttpPost("move-many")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveMany([FromBody] MoveImagesCommand command,
		CancellationToken cancellationToken){
		var urls = await moveImagesCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { urls }));
	}
}