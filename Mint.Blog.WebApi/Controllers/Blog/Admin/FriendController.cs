using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Friend.Commands.CreateAdminFriend;
using Mint.Blog.Application.Blog.Friend.Commands.DeleteFriend;
using Mint.Blog.Application.Blog.Friend.Commands.MoveFriendSortFirst;
using Mint.Blog.Application.Blog.Friend.Commands.MoveFriendSortLast;
using Mint.Blog.Application.Blog.Friend.Commands.SetFriendStatus;
using Mint.Blog.Application.Blog.Friend.Commands.SetFriendTop;
using Mint.Blog.Application.Blog.Friend.Commands.UpdateFriend;
using Mint.Blog.Application.Blog.Friend.Commands.UpdateFriendSort;
using Mint.Blog.Application.Blog.Friend.Queries.GetAdminFriendPageList;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/friend")]
public sealed class FriendController(
	IGetAdminFriendPageListQueryService adminFriendPageListQueryService,
	CreateAdminFriendCommandHandler createAdminFriendCommandHandler,
	DeleteFriendCommandHandler deleteFriendCommandHandler,
	UpdateFriendCommandHandler updateFriendCommandHandler,
	SetFriendTopCommandHandler setFriendTopCommandHandler,
	SetFriendStatusCommandHandler setFriendStatusCommandHandler,
	UpdateFriendSortCommandHandler updateFriendSortCommandHandler,
	MoveFriendSortFirstCommandHandler moveFriendSortFirstCommandHandler,
	MoveFriendSortLastCommandHandler moveFriendSortLastCommandHandler) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<AdminFriendPageItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<PagedResult<AdminFriendPageItemDto>>>> Get(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		[FromQuery] string? name = null,
		[FromQuery] DateOnly? startDate = null,
		[FromQuery] DateOnly? endDate = null,
		[FromQuery] string? sortOrder = null,
		CancellationToken cancellationToken = default){
		var result = await adminFriendPageListQueryService.GetAsync(
			new GetAdminFriendPageListQuery(pageNumber, pageSize, name, startDate, endDate, sortOrder),
			cancellationToken);

		return Ok(ApiResponse<PagedResult<AdminFriendPageItemDto>>.Ok(result));
	}

	[HttpPost]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Create([FromBody] CreateAdminFriendCommand command,
		CancellationToken cancellationToken){
		var id = await createAdminFriendCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("{friendId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long friendId, [FromBody] UpdateFriendCommand command,
		CancellationToken cancellationToken){
		await updateFriendCommandHandler.HandleAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}

	[HttpPatch("{friendId:long}/top")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> SetTop(long friendId, [FromBody] SetFriendTopCommand command,
		CancellationToken cancellationToken){
		await setFriendTopCommandHandler.HandleAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId, isTop = command.IsTop }));
	}

	[HttpPatch("{friendId:long}/status")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> SetStatus(long friendId,
		[FromBody] SetFriendStatusCommand command, CancellationToken cancellationToken){
		await setFriendStatusCommandHandler.HandleAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId, status = command.Status }));
	}

	[HttpPatch("{friendId:long}/sort")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdateSort(long friendId,
		[FromBody] UpdateFriendSortCommand command, CancellationToken cancellationToken){
		await updateFriendSortCommandHandler.HandleAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId, sort = command.Sort }));
	}

	[HttpPatch("{friendId:long}/sort/first")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortFirst(long friendId,
		CancellationToken cancellationToken){
		await moveFriendSortFirstCommandHandler.HandleAsync(new MoveFriendSortFirstCommand(friendId),
			cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}

	[HttpPatch("{friendId:long}/sort/last")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortLast(long friendId,
		CancellationToken cancellationToken){
		await moveFriendSortLastCommandHandler.HandleAsync(new MoveFriendSortLastCommand(friendId), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}

	[HttpPatch("{friendId:long}/delete")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long friendId, [FromBody] DeleteFriendCommand command,
		CancellationToken cancellationToken){
		await deleteFriendCommandHandler.HandleAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}
}