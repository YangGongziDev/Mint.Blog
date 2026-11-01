using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Model.Dtos.System;
using Mint.Blog.Model.Vos.System;
using Mint.Blog.Service.IService.System;

namespace Mint.Blog.WebApi.Controllers.System;

[ApiController]
[Route("api/system/auth")]
public sealed class AuthController(IAuthService service) : ControllerBase {
    [HttpGet("info")]
    [Authorize]
    public async Task<IActionResult> Info([FromServices] IAdminIdentityQuery query, CancellationToken cancellationToken) {
        var username = User.Identity?.Name;
        var user = string.IsNullOrEmpty(username) ? null : await query.GetAsync(username, cancellationToken);
        return user is null
            ? Unauthorized(ApiResponse<object>.Fail(ErrorCodes.Unauthorized, "账号不存在或已禁用"))
            : Ok(ApiResponse<AdminUser>.Ok(user));
    }
    [HttpPost("login")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<LoginResult>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<LoginResult>>> Login([FromBody] LoginCommand command, CancellationToken cancellationToken) {
        HttpContext.Items["AdminLoginUsername"] = command.UserName;
        var result = await service.LoginAsync(command, cancellationToken);
        return Ok(ApiResponse<LoginResult>.Ok(result));
    }
    [HttpPost("refresh")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<LoginResult>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<LoginResult>>> Refresh([FromBody] RefreshTokenCommand command, CancellationToken cancellationToken) {
        var result = await service.RefreshAsync(command, cancellationToken);
        return Ok(ApiResponse<LoginResult>.Ok(result));
    }
    [HttpPost("logout")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<object>>> Logout([FromBody] LogoutCommand command, CancellationToken cancellationToken) {
        await service.LogoutAsync(command, cancellationToken);
        return Ok(ApiResponse<object>.Ok(default(object?)));
    }
}
