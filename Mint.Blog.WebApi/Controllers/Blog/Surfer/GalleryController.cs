using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Dtos.Blog.Gallery;
using Mint.Blog.Model.Vos.Blog.Gallery;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/gallery")]
public sealed class GalleryController(IGalleryService galleryQueryService) : ControllerBase {
	[HttpGet("categories")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<GalleryCategoryVo>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<GalleryCategoryVo>>>> GetCategories(
		CancellationToken cancellationToken = default){
		var result = await galleryQueryService.GetCategoryOptionsAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<GalleryCategoryVo>>.Ok(result));
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
		var result = await galleryQueryService.GetImagesAsync(new GalleryImagePageQuery(pageNumber, pageSize, keyword, categoryId, true, resolution, ratio, sortOrder), cancellationToken);
		return Ok(ApiResponse<PagedResult<GalleryImageVo>>.Ok(result));
	}
}
