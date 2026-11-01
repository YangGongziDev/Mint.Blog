using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Friend;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Friend;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/friend")]
public sealed class FriendController(IFriendService friendService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<AdminFriendPageItemVo>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<PagedResult<AdminFriendPageItemVo>>>> Get(
		[FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10, [FromQuery] string? name = null,
		[FromQuery] DateOnly? startDate = null, [FromQuery] DateOnly? endDate = null,
		[FromQuery] string? sortOrder = null, CancellationToken cancellationToken = default){
		var result = await friendService.GetAsync(new GetAdminFriendPageListQuery(pageNumber, pageSize, name, startDate, endDate, sortOrder), cancellationToken);
		return Ok(ApiResponse<PagedResult<AdminFriendPageItemVo>>.Ok(result));
	}

	[HttpPost]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Create([FromBody] CreateAdminFriendCommand command, CancellationToken cancellationToken){
		var id = await friendService.CreateAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}

	[HttpPut("{friendId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long friendId, [FromBody] UpdateFriendCommand command, CancellationToken cancellationToken){
		await friendService.UpdateAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}

	[HttpPatch("{friendId:long}/top")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> SetTop(long friendId, [FromBody] SetFriendTopCommand command, CancellationToken cancellationToken){
		await friendService.SetTopAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId, isTop = command.IsTop }));
	}

	[HttpPatch("{friendId:long}/status")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> SetStatus(long friendId, [FromBody] SetFriendStatusCommand command, CancellationToken cancellationToken){
		await friendService.SetStatusAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId, status = command.Status }));
	}

	[HttpPatch("{friendId:long}/sort")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdateSort(long friendId, [FromBody] UpdateFriendSortCommand command, CancellationToken cancellationToken){
		await friendService.UpdateSortAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId, sort = command.Sort }));
	}

	[HttpPatch("{friendId:long}/sort/first")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortFirst(long friendId, CancellationToken cancellationToken){
		await friendService.MoveSortFirstAsync(new MoveFriendSortFirstCommand(friendId), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}

	[HttpPatch("{friendId:long}/sort/last")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> MoveSortLast(long friendId, CancellationToken cancellationToken){
		await friendService.MoveSortLastAsync(new MoveFriendSortLastCommand(friendId), cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}

	[HttpPatch("{friendId:long}/delete")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long friendId, [FromBody] DeleteFriendCommand command, CancellationToken cancellationToken){
		await friendService.DeleteAsync(command with { FriendId = friendId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = friendId }));
	}
}
