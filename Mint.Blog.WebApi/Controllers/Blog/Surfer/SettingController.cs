using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Setting.Queries.GetBlogSettingsDetail;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/setting")]
public sealed class SettingController(IGetBlogSettingsDetailQueryService blogSettingsDetailQueryService)
	: ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<BlogSettingsDetailDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<BlogSettingsDetailDto>>> Get(CancellationToken cancellationToken){
		var result = await blogSettingsDetailQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<BlogSettingsDetailDto>.Ok(result, null));
	}
}