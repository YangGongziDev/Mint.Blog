using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos.Blog.Statistics;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/dashboard")]
public sealed class DashboardController(IStatisticsService statisticsService) : ControllerBase {
    [HttpGet("statistics")]
    [ProducesResponseType(typeof(ApiResponse<AdminDashboardStatisticsDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<AdminDashboardStatisticsDto>>> GetStatistics(CancellationToken cancellationToken) {
        var result = await statisticsService.GetDashboardAsync(cancellationToken);
        return Ok(ApiResponse<AdminDashboardStatisticsDto>.Ok(result));
    }

    [HttpGet("pv-statistics")]
    [ProducesResponseType(typeof(ApiResponse<AdminDashboardPvStatisticsDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<AdminDashboardPvStatisticsDto>>> GetPvStatistics(CancellationToken cancellationToken) {
        var result = await statisticsService.GetPvAsync(cancellationToken);
        return Ok(ApiResponse<AdminDashboardPvStatisticsDto>.Ok(result));
    }

    [HttpGet("publish-article-statistics")]
    [ProducesResponseType(typeof(ApiResponse<AdminDashboardPublishArticleStatisticsDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<AdminDashboardPublishArticleStatisticsDto>>> GetPublishArticleStatistics(CancellationToken cancellationToken) {
        var result = await statisticsService.GetPublishAsync(cancellationToken);
        return Ok(ApiResponse<AdminDashboardPublishArticleStatisticsDto>.Ok(result));
    }
}
