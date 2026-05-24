using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Category.Commands.CreateCategory;
using Mint.Blog.Application.Blog.Category.Commands.DeleteCategory;
using Mint.Blog.Application.Blog.Category.Commands.MoveCategorySortFirst;
using Mint.Blog.Application.Blog.Category.Commands.MoveCategorySortLast;
using Mint.Blog.Application.Blog.Category.Commands.UpdateCategory;
using Mint.Blog.Application.Blog.Category.Commands.UpdateCategorySort;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryPageList;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/category")]
public sealed class CategoryController(
	IGetCategoryListQueryService categoryListQueryService,
	IGetCategoryPageListQueryService categoryPageListQueryService,
	CreateCategoryCommandHandler createCategoryCommandHandler,
	UpdateCategoryCommandHandler updateCategoryCommandHandler,
	UpdateCategorySortCommandHandler updateCategorySortCommandHandler,
	MoveCategorySortFirstCommandHandler moveCategorySortFirstCommandHandler,
	MoveCategorySortLastCommandHandler moveCategorySortLastCommandHandler,
	DeleteCategoryCommandHandler deleteCategoryCommandHandler) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<CategoryListItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<CategoryListItemDto>>>> Get(
		CancellationToken cancellationToken){
		var categories = await categoryListQueryService.GetAsync(cancellationToken);
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
		CancellationToken cancellationToken = default){
		var categories = await categoryPageListQueryService.GetAsync(
			new CategoryPageListQuery(pageNumber, pageSize, keyword, name, startDate, endDate),
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
		var id = await createCategoryCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("{categoryId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long categoryId,
		[FromBody] UpdateCategoryCommand command, CancellationToken cancellationToken){
		await updateCategoryCommandHandler.HandleAsync(command with { CategoryId = categoryId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId }));
	}

	[HttpPatch("{categoryId:long}/sort")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdateSort(long categoryId,
		[FromBody] UpdateCategorySortCommand command, CancellationToken cancellationToken){
		await updateCategorySortCommandHandler.HandleAsync(command with { CategoryId = categoryId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId, sort = command.Sort }));
	}

	[HttpPatch("{categoryId:long}/sort/first")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortFirst(long categoryId,
		CancellationToken cancellationToken){
		await moveCategorySortFirstCommandHandler.HandleAsync(new MoveCategorySortFirstCommand(categoryId),
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
		await moveCategorySortLastCommandHandler.HandleAsync(new MoveCategorySortLastCommand(categoryId),
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
		await deleteCategoryCommandHandler.HandleAsync(new DeleteCategoryCommand(categoryId, request?.DeleteType ?? 1),
			cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = categoryId }));
	}
}

public sealed record DeleteCategoryRequest(int DeleteType);
