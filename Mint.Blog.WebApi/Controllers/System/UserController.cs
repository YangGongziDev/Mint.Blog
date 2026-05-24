using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.User.Commands.DeleteUser;
using Mint.Blog.Application.System.User.Commands.UpdateSystemUserPassword;
using Mint.Blog.Application.System.User.Commands.UpdateUser;
using Mint.Blog.Application.System.User.Queries.GetSystemUserInfo;
using Mint.Blog.Application.System.User.Queries.GetUserList;

namespace Mint.Blog.WebApi.Controllers.System;

[ApiController]
[Authorize]
[Route("api/system/user")]
public sealed class UserController(
	DeleteUserCommandHandler deleteUserCommandHandler,
	UpdateSystemUserPasswordCommandHandler updateSystemUserPasswordCommandHandler,
	UpdateUserCommandHandler updateUserCommandHandler,
	IGetSystemUserInfoQueryService getSystemUserInfoQueryService) : ControllerBase {

	[HttpPut("{userId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long userId, [FromBody] UpdateUserCommand command,
		CancellationToken cancellationToken){
		await updateUserCommandHandler.HandleAsync(command with { UserId = userId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = userId }));
	}

	[HttpPatch("{userId:long}/delete")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long userId, [FromBody] DeleteUserCommand command,
		CancellationToken cancellationToken){
		await deleteUserCommandHandler.HandleAsync(command with { UserId = userId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = userId }));
	}

	[HttpPatch("password")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> UpdatePassword(
		[FromBody] UpdateSystemUserPasswordCommand command, CancellationToken cancellationToken){
		await updateSystemUserPasswordCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}

	[HttpGet("me")]
	[ProducesResponseType(typeof(ApiResponse<SystemUserInfoDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<SystemUserInfoDto>>> GetMyInfo(CancellationToken cancellationToken){
		var userName = User.FindFirstValue(ClaimTypes.Name) ?? User.Identity?.Name;
		if (string.IsNullOrWhiteSpace(userName))
			return Unauthorized(ApiResponse<SystemUserInfoDto>.Fail(ErrorCodes.Unauthorized, "未登录或登录状态无效。"));

		var userInfo = await getSystemUserInfoQueryService.GetAsync(userName, cancellationToken);
		if (userInfo is null)
			return Unauthorized(ApiResponse<SystemUserInfoDto>.Fail(ErrorCodes.Unauthorized, "未找到当前登录用户信息。"));

		return Ok(ApiResponse<SystemUserInfoDto>.Ok(userInfo));
	}
}
