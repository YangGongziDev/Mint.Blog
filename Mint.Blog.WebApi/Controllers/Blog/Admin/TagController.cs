using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Tag.Commands.CreateTag;
using Mint.Blog.Application.Blog.Tag.Commands.DeleteTag;
using Mint.Blog.Application.Blog.Tag.Commands.MoveTagSortFirst;
using Mint.Blog.Application.Blog.Tag.Commands.MoveTagSortLast;
using Mint.Blog.Application.Blog.Tag.Commands.UpdateTag;
using Mint.Blog.Application.Blog.Tag.Commands.UpdateTagSort;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagList;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagPageList;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/tag")]
public sealed class TagController(
	IGetTagListQueryService tagListQueryService,
	IGetTagPageListQueryService tagPageListQueryService,
	CreateTagCommandHandler createTagCommandHandler,
	UpdateTagCommandHandler updateTagCommandHandler,
	UpdateTagSortCommandHandler updateTagSortCommandHandler,
	MoveTagSortFirstCommandHandler moveTagSortFirstCommandHandler,
	MoveTagSortLastCommandHandler moveTagSortLastCommandHandler,
	DeleteTagCommandHandler deleteTagCommandHandler) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<TagListItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<TagListItemDto>>>> Get(
		CancellationToken cancellationToken){
		var tags = await tagListQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<TagListItemDto>>.Ok(tags));
	}

	[HttpGet("page")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<TagListItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<PagedResult<TagListItemDto>>>> GetPage(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		[FromQuery] string? keyword = null,
		[FromQuery] string? name = null,
		[FromQuery] DateOnly? startDate = null,
		[FromQuery] DateOnly? endDate = null,
		[FromQuery] string? sortOrder = null,
		CancellationToken cancellationToken = default){
		var tags = await tagPageListQueryService.GetAsync(
			new TagPageListQuery(pageNumber, pageSize, keyword, name, startDate, endDate, sortOrder),
			cancellationToken);
		return Ok(ApiResponse<PagedResult<TagListItemDto>>.Ok(tags));
	}

	[HttpPost]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Create([FromBody] CreateTagCommand command,
		CancellationToken cancellationToken){
		var id = await createTagCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("{tagId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long tagId, [FromBody] UpdateTagCommand command,
		CancellationToken cancellationToken){
		await updateTagCommandHandler.HandleAsync(command with { TagId = tagId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = tagId }));
	}

	[HttpPatch("{tagId:long}/sort")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdateSort(long tagId,
		[FromBody] UpdateTagSortCommand command, CancellationToken cancellationToken){
		await updateTagSortCommandHandler.HandleAsync(command with { TagId = tagId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = tagId, sort = command.Sort }));
	}

	[HttpPatch("{tagId:long}/sort/first")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortFirst(long tagId,
		CancellationToken cancellationToken){
		await moveTagSortFirstCommandHandler.HandleAsync(new MoveTagSortFirstCommand(tagId), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = tagId }));
	}

	[HttpPatch("{tagId:long}/sort/last")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortLast(long tagId,
		CancellationToken cancellationToken){
		await moveTagSortLastCommandHandler.HandleAsync(new MoveTagSortLastCommand(tagId), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = tagId }));
	}

	[HttpDelete("{tagId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long tagId, [FromBody] DeleteTagRequest? request,
		CancellationToken cancellationToken){
		await deleteTagCommandHandler.HandleAsync(new DeleteTagCommand(tagId, request?.DeleteType ?? 1), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = tagId }));
	}
}

public sealed record DeleteTagRequest(int DeleteType);
