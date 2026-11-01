using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Column;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Column;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/column")]
public sealed class ColumnController(
	IColumnService columnService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<AdminColumnPageItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<PagedResult<AdminColumnPageItemDto>>>> Get(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		[FromQuery] string? title = null,
		[FromQuery] DateOnly? startDate = null,
		[FromQuery] DateOnly? endDate = null,
		[FromQuery] string? sortOrder = null,
		CancellationToken cancellationToken = default){
		var result = await columnService.GetAsync(
			new GetAdminColumnPageListQuery(pageNumber, pageSize, title, startDate, endDate, sortOrder),
			cancellationToken);

		return Ok(ApiResponse<PagedResult<AdminColumnPageItemDto>>.Ok(result));
	}

	[HttpGet("{columnId:long}/catalog")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<AdminColumnCatalogItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<AdminColumnCatalogItemDto>>>> GetCatalog(long columnId,
		CancellationToken cancellationToken){
		var result = await columnService.GetAsync(columnId, cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<AdminColumnCatalogItemDto>>.Ok(result));
	}

	[HttpPost]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Create([FromBody] CreateColumnCommand command,
		CancellationToken cancellationToken){
		var id = await columnService.CreateAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("{columnId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long columnId, [FromBody] UpdateColumnCommand command,
		CancellationToken cancellationToken){
		await columnService.UpdateAsync(command with { ColumnId = columnId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = columnId }));
	}

	[HttpPatch("{columnId:long}/publish")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> SetPublish(long columnId,
		[FromBody] SetColumnPublishCommand command, CancellationToken cancellationToken){
		await columnService.SetPublishAsync(command with { ColumnId = columnId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = columnId, isPublish = command.IsPublish }));
	}

	[HttpPatch("{columnId:long}/top")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> SetTop(long columnId, [FromBody] SetColumnTopCommand command,
		CancellationToken cancellationToken){
		await columnService.SetTopAsync(command with { ColumnId = columnId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = columnId, isTop = command.IsTop }));
	}

	[HttpPatch("{columnId:long}/sort")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdateSort(long columnId,
		[FromBody] UpdateColumnSortCommand command, CancellationToken cancellationToken){
		await columnService.UpdateSortAsync(command with { ColumnId = columnId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = columnId, sort = command.Sort }));
	}

	[HttpPut("{columnId:long}/catalog")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdateCatalog(long columnId,
		[FromBody] UpdateColumnCatalogCommand command, CancellationToken cancellationToken){
		await columnService.UpdateCatalogAsync(command with { ColumnId = columnId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = columnId }));
	}

	[HttpDelete("{columnId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long columnId, [FromBody] DeleteColumnRequest? request,
		CancellationToken cancellationToken){
		await columnService.DeleteAsync(new DeleteColumnCommand(columnId, request?.DeleteType ?? 1), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = columnId }));
	}
}
