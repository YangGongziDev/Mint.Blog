using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Comment;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/comment")]
public sealed class CommentController(
	ICommentService commentService) : ControllerBase {
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
		var result = await commentService.GetAsync(query, cancellationToken);
		return Ok(ApiResponse<PagedResult<AdminCommentPageItemDto>>.Ok(result));
	}

	[HttpPatch("{id:long}/delete")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long id, [FromBody] DeleteCommentCommand command,
		CancellationToken cancellationToken){
		await commentService.DeleteAsync(command with { Id = id }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}

	[HttpPatch("{id:long}/examine")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Examine(long id, [FromBody] ExamineCommentCommand command,
		CancellationToken cancellationToken){
		await commentService.ExamineAsync(command with { Id = id }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}
}