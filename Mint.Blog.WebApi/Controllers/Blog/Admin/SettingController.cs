using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Setting;
using Mint.Blog.Model.Vos.Blog.Setting;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/setting")]
public sealed class SettingController(IBlogSettingService settingService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<BlogSettingsDetailVo>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<BlogSettingsDetailVo>>> Get(CancellationToken cancellationToken){
		var result = await settingService.GetAsync(cancellationToken);
		return Ok(ApiResponse<BlogSettingsDetailVo>.Ok(result, null));
	}

	[HttpPut]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update([FromBody] UpdateBlogSettingsDto command,
		CancellationToken cancellationToken){
		await settingService.UpdateAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}
}
