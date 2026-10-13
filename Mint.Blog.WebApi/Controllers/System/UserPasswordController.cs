using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.User.Commands;

namespace Mint.Blog.WebApi.Controllers.System;

[ApiController]
[Authorize]
[Route("api/users/change-password")]
public sealed class UserPasswordController(ChangeOwnPasswordHandler handler) : ControllerBase {
	[HttpPost]
	public async Task<IActionResult> Change(ChangeOwnPasswordCommand command, CancellationToken cancellationToken){
		await handler.HandleAsync(User.Identity!.Name!, command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(null));
	}
}
