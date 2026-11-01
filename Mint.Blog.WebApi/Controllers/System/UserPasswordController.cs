using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Model.Dtos.System;
using Mint.Blog.Service.IService.System;
namespace Mint.Blog.WebApi.Controllers.System;
[ApiController]
[Authorize]
[Route("api/system/users/change-password")]
public sealed class UserPasswordController(IAuthService service) : ControllerBase {
    [HttpPost]
    public async Task<IActionResult> Change(ChangeOwnPasswordCommand command, CancellationToken cancellationToken) {
        await service.ChangePasswordAsync(User.Identity!.Name!, command, cancellationToken);
        return Ok(ApiResponse<object>.Ok(null));
    }
}
