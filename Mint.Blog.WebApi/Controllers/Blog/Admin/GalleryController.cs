using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Dtos.Blog.Gallery;
using Mint.Blog.Model.Vos.Blog.Gallery;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/gallery")]
public sealed class GalleryController(IGalleryService galleryService) : ControllerBase {
	[HttpGet("categories")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<GalleryCategoryVo>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<GalleryCategoryVo>>>> GetCategories(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 20,
		[FromQuery] string? keyword = null,
		CancellationToken cancellationToken = default){
		var result = await galleryService.GetCategoriesAsync(new GalleryCategoryPageQuery(pageNumber, pageSize, keyword), cancellationToken);
		return Ok(ApiResponse<PagedResult<GalleryCategoryVo>>.Ok(result));
	}

	[HttpGet("categories/options")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<GalleryCategoryVo>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<GalleryCategoryVo>>>> GetCategoryOptions(
		CancellationToken cancellationToken = default){
		var result = await galleryService.GetCategoryOptionsAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<GalleryCategoryVo>>.Ok(result));
	}

	[HttpPost("categories")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> CreateCategory([FromBody] SaveGalleryCategoryCommand command,
		CancellationToken cancellationToken){
		var id = await galleryService.CreateCategoryAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("categories/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> UpdateCategory(long id,
		[FromBody] SaveGalleryCategoryCommand command, CancellationToken cancellationToken){
		await galleryService.UpdateCategoryAsync(id, command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpDelete("categories/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> DeleteCategory(long id, CancellationToken cancellationToken){
		await galleryService.DeleteCategoryAsync(id, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpGet("images")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<GalleryImageVo>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<GalleryImageVo>>>> GetImages(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 20,
		[FromQuery] string? keyword = null,
		[FromQuery] long? categoryId = null,
		[FromQuery] string? resolution = null,
		[FromQuery] string? ratio = null,
		[FromQuery] string? sortOrder = null,
		CancellationToken cancellationToken = default){
		var result = await galleryService.GetImagesAsync(new GalleryImagePageQuery(pageNumber, pageSize, keyword, categoryId, false, resolution, ratio, sortOrder), cancellationToken);
		return Ok(ApiResponse<PagedResult<GalleryImageVo>>.Ok(result));
	}

	[HttpPost("images")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> CreateImage([FromBody] SaveGalleryImageCommand command,
		CancellationToken cancellationToken){
		var id = await galleryService.CreateImageAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("images/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> UpdateImage(long id,
		[FromBody] SaveGalleryImageCommand command, CancellationToken cancellationToken){
		await galleryService.UpdateImageAsync(id, command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpDelete("images/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> DeleteImage(long id, CancellationToken cancellationToken){
		await galleryService.DeleteImageAsync(id, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}
}
