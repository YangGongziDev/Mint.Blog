using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Comment.Commands.DeleteComment;
using Mint.Blog.Application.Blog.Comment.Commands.ExamineComment;
using Mint.Blog.Application.Blog.Comment.Queries.GetAdminCommentPageList;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/comment")]
public sealed class CommentController(
	IGetAdminCommentPageListQueryService commentPageListQueryService,
	DeleteCommentCommandHandler deleteCommentCommandHandler,
	ExamineCommentCommandHandler examineCommentCommandHandler) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<AdminCommentPageItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<PagedResult<AdminCommentPageItemDto>>>> Get(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		[FromQuery] string? routerUrl = null,
		[FromQuery] DateOnly? startDate = null,
		[FromQuery] DateOnly? endDate = null,
		[FromQuery] int? status = null,
		[FromQuery] string? sortOrder = null,
		CancellationToken cancellationToken = default){
		var query = new GetAdminCommentPageListQuery(pageNumber, pageSize, routerUrl, startDate, endDate, status,
			sortOrder);
		var result = await commentPageListQueryService.GetAsync(query, cancellationToken);
		return Ok(ApiResponse<PagedResult<AdminCommentPageItemDto>>.Ok(result));
	}

	[HttpPatch("{id:long}/delete")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long id, [FromBody] DeleteCommentCommand command,
		CancellationToken cancellationToken){
		await deleteCommentCommandHandler.HandleAsync(command with { Id = id }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}

	[HttpPatch("{id:long}/examine")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Examine(long id, [FromBody] ExamineCommentCommand command,
		CancellationToken cancellationToken){
		await examineCommentCommandHandler.HandleAsync(command with { Id = id }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}
}