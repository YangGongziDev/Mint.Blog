using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos.Blog.Category;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/category")]
public sealed class CategoryController(ICategoryService categoryListQueryService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<CategoryListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<CategoryListItemDto>>>> Get(
		CancellationToken cancellationToken){
		var categories = await categoryListQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<CategoryListItemDto>>.Ok(categories));
	}
}