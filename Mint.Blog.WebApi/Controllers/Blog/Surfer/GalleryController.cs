using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Gallery;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/gallery")]
public sealed class GalleryController(IGalleryQueryService galleryQueryService) : ControllerBase {
	[HttpGet("categories")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<GalleryCategoryDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<GalleryCategoryDto>>>> GetCategories(
		CancellationToken cancellationToken = default){
		var result = await galleryQueryService.GetCategoryOptionsAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<GalleryCategoryDto>>.Ok(result));
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
		var result = await galleryQueryService.GetImagesAsync(new GalleryImagePageQuery(pageNumber, pageSize, keyword, categoryId, true, resolution, ratio, sortOrder), cancellationToken);
		return Ok(ApiResponse<PagedResult<GalleryImageDto>>.Ok(result));
	}
}
