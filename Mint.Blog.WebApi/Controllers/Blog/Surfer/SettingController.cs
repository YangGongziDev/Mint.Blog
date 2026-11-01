using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos.Blog.Setting;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/setting")]
public sealed class SettingController(IBlogSettingService blogSettingsDetailQueryService)
	: ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<BlogSettingsDetailVo>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<BlogSettingsDetailVo>>> Get(CancellationToken cancellationToken){
		var result = await blogSettingsDetailQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<BlogSettingsDetailVo>.Ok(result, null));
	}
}
