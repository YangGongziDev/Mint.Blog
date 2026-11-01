using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Category;
using Mint.Blog.Model.Dtos.Blog.Category;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/category")]
public sealed class CategoryController(ICategoryService service) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<CategoryListItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<CategoryListItemDto>>>> Get(
		CancellationToken cancellationToken){
		var categories = await service.GetAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<CategoryListItemDto>>.Ok(categories));
	}

	[HttpGet("page")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<CategoryListItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<PagedResult<CategoryListItemDto>>>> GetPage(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		[FromQuery] string? keyword = null,
		[FromQuery] string? name = null,
		[FromQuery] DateOnly? startDate = null,
		[FromQuery] DateOnly? endDate = null,
		[FromQuery] string? sortOrder = null,
		CancellationToken cancellationToken = default){
		var categories = await service.GetAsync(
			new CategoryPageListQuery(pageNumber, pageSize, keyword, name, startDate, endDate, sortOrder),
			cancellationToken);
		return Ok(ApiResponse<PagedResult<CategoryListItemDto>>.Ok(categories));
	}

	[HttpPost]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Create([FromBody] CreateCategoryCommand command,
		CancellationToken cancellationToken){
		var id = await service.CreateAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("{categoryId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long categoryId,
		[FromBody] UpdateCategoryCommand command, CancellationToken cancellationToken){
		await service.UpdateAsync(command with { CategoryId = categoryId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId }));
	}

	[HttpPatch("{categoryId:long}/sort")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdateSort(long categoryId,
		[FromBody] UpdateCategorySortCommand command, CancellationToken cancellationToken){
		await service.UpdateSortAsync(command with { CategoryId = categoryId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId, sort = command.Sort }));
	}

	[HttpPatch("{categoryId:long}/sort/first")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortFirst(long categoryId,
		CancellationToken cancellationToken){
		await service.MoveSortFirstAsync(new MoveCategorySortFirstCommand(categoryId),
			cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId }));
	}

	[HttpPatch("{categoryId:long}/sort/last")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortLast(long categoryId,
		CancellationToken cancellationToken){
		await service.MoveSortLastAsync(new MoveCategorySortLastCommand(categoryId),
			cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId }));
	}

	[HttpDelete("{categoryId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long categoryId,
		[FromBody] DeleteCategoryRequest? request, CancellationToken cancellationToken){
		await service.DeleteAsync(new DeleteCategoryCommand(categoryId, request?.DeleteType ?? 1),
			cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId }));
	}
}
