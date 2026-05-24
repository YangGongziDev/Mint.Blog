using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Statistics.Queries.GetBlogStatistics;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

/// <summary>
///     前台统计信息接口。
/// </summary>
[ApiController]
[Route("api/blog/surfer/statistics")]
public sealed class StatisticsController(IGetBlogStatisticsQueryService blogStatisticsQueryService)
	: ControllerBase {
	/// <summary>
	///     获取前台统计信息。
	/// </summary>
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<BlogStatisticsDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<BlogStatisticsDto>>> Get(CancellationToken cancellationToken){
		var result = await blogStatisticsQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<BlogStatisticsDto>.Ok(result));
	}
}