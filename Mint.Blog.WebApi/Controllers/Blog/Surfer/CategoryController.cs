using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/category")]
public sealed class CategoryController(IGetCategoryListQueryService categoryListQueryService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<CategoryListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<CategoryListItemDto>>>> Get(
		CancellationToken cancellationToken){
		var categories = await categoryListQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<CategoryListItemDto>>.Ok(categories));
	}
}