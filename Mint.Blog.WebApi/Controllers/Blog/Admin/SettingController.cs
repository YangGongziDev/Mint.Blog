using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Setting.Commands.UpdateBlogSettings;
using Mint.Blog.Application.Blog.Setting.Queries.GetBlogSettingsDetail;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/setting")]
public sealed class SettingController(
	IGetBlogSettingsDetailQueryService blogSettingsDetailQueryService,
	UpdateBlogSettingsCommandHandler updateBlogSettingsCommandHandler) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<BlogSettingsDetailDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<BlogSettingsDetailDto>>> Get(CancellationToken cancellationToken){
		var result = await blogSettingsDetailQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<BlogSettingsDetailDto>.Ok(result, null));
	}

	[HttpPut]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update([FromBody] UpdateBlogSettingsCommand command,
		CancellationToken cancellationToken){
		await updateBlogSettingsCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(default(object?)));
	}
}