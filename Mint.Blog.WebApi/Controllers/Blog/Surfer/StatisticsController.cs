using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos.Blog.Statistics;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/statistics")]
public sealed class StatisticsController(IStatisticsService statisticsService) : ControllerBase {
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<BlogStatisticsDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<BlogStatisticsDto>>> Get(CancellationToken cancellationToken) {
        var result = await statisticsService.GetBlogAsync(cancellationToken);
        return Ok(ApiResponse<BlogStatisticsDto>.Ok(result));
    }
}
