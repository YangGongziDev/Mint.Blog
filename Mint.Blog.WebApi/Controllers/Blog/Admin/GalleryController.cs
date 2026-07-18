using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Gallery;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/gallery")]
public sealed class GalleryController(
	IGalleryQueryService galleryQueryService,
	IGalleryCommandService galleryCommandService) : ControllerBase {
	[HttpGet("categories")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<GalleryCategoryDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<GalleryCategoryDto>>>> GetCategories(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 20,
		[FromQuery] string? keyword = null,
		CancellationToken cancellationToken = default){
		var result = await galleryQueryService.GetCategoriesAsync(new GalleryCategoryPageQuery(pageNumber, pageSize, keyword), cancellationToken);
		return Ok(ApiResponse<PagedResult<GalleryCategoryDto>>.Ok(result));
	}

	[HttpGet("categories/options")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<GalleryCategoryDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<GalleryCategoryDto>>>> GetCategoryOptions(
		CancellationToken cancellationToken = default){
		var result = await galleryQueryService.GetCategoryOptionsAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<GalleryCategoryDto>>.Ok(result));
	}

	[HttpPost("categories")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> CreateCategory([FromBody] SaveGalleryCategoryCommand command,
		CancellationToken cancellationToken){
		var id = await galleryCommandService.CreateCategoryAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("categories/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> UpdateCategory(long id,
		[FromBody] SaveGalleryCategoryCommand command, CancellationToken cancellationToken){
		await galleryCommandService.UpdateCategoryAsync(id, command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpDelete("categories/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> DeleteCategory(long id, CancellationToken cancellationToken){
		await galleryCommandService.DeleteCategoryAsync(id, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpGet("images")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<GalleryImageDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<GalleryImageDto>>>> GetImages(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 20,
		[FromQuery] string? keyword = null,
		[FromQuery] long? categoryId = null,
		[FromQuery] string? resolution = null,
		[FromQuery] string? ratio = null,
		[FromQuery] string? sortOrder = null,
		CancellationToken cancellationToken = default){
		var result = await galleryQueryService.GetImagesAsync(new GalleryImagePageQuery(pageNumber, pageSize, keyword, categoryId, false, resolution, ratio, sortOrder), cancellationToken);
		return Ok(ApiResponse<PagedResult<GalleryImageDto>>.Ok(result));
	}

	[HttpPost("images")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> CreateImage([FromBody] SaveGalleryImageCommand command,
		CancellationToken cancellationToken){
		var id = await galleryCommandService.CreateImageAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("images/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> UpdateImage(long id,
		[FromBody] SaveGalleryImageCommand command, CancellationToken cancellationToken){
		await galleryCommandService.UpdateImageAsync(id, command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpDelete("images/{id:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	public async Task<ActionResult<ApiResponse<object>>> DeleteImage(long id, CancellationToken cancellationToken){
		await galleryCommandService.DeleteImageAsync(id, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}
}
