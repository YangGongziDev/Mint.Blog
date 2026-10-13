using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Auth.Login;
using Mint.Blog.Application.System.Auth.Logout;
using Mint.Blog.Application.System.Auth.RefreshToken;

namespace Mint.Blog.WebApi.Controllers.System;

[ApiController]
[Route("api/auth")]
public sealed class AuthController(
	LoginCommandHandler loginCommandHandler,
	RefreshTokenCommandHandler refreshTokenCommandHandler,
	LogoutCommandHandler logoutCommandHandler) : ControllerBase {
	[HttpGet("info")]
	[Authorize]
	public async Task<IActionResult> Info([FromServices] Mint.Blog.Application.System.Auth.IAdminIdentityQuery query, CancellationToken cancellationToken){
		var username = User.Identity?.Name;
		var user = string.IsNullOrEmpty(username) ? null : await query.GetAsync(username, cancellationToken);
		return user is null
			? Unauthorized(ApiResponse<object>.Fail(ErrorCodes.Unauthorized, "账号不存在或已禁用"))
			: Ok(ApiResponse<Mint.Blog.Application.System.Auth.AdminUser>.Ok(user));
	}

	[HttpPost("login")]
	[AllowAnonymous]
	[ProducesResponseType(typeof(ApiResponse<LoginResult>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<LoginResult>>> Login([FromBody] LoginCommand command,
		CancellationToken cancellationToken){
		HttpContext.Items["AdminLoginUsername"] = command.UserName;
		var result = await loginCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<LoginResult>.Ok(result));
	}

	[HttpPost("refresh")]
	[AllowAnonymous]
	[ProducesResponseType(typeof(ApiResponse<LoginResult>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<LoginResult>>> Refresh([FromBody] RefreshTokenCommand command,
		CancellationToken cancellationToken){
		var result = await refreshTokenCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<LoginResult>.Ok(result));
	}

	[HttpPost("logout")]
	[AllowAnonymous]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<object>>> Logout([FromBody] LogoutCommand command,
		CancellationToken cancellationToken){
		await logoutCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}
}
