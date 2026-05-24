using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPublishArticleStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPvStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardStatistics;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

/// <summary>
///     后台仪表盘统计接口。
/// </summary>
[ApiController]
[Authorize]
[Route("api/blog/admin/dashboard")]
public sealed class DashboardController(
	IGetAdminDashboardStatisticsQueryService dashboardStatisticsQueryService,
	IGetAdminDashboardPvStatisticsQueryService dashboardPvStatisticsQueryService,
	IGetAdminDashboardPublishArticleStatisticsQueryService dashboardPublishArticleStatisticsQueryService)
	: ControllerBase {
	/// <summary>
	///     获取后台仪表盘基础统计信息。
	/// </summary>
	[HttpGet("statistics")]
	[ProducesResponseType(typeof(ApiResponse<AdminDashboardStatisticsDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<AdminDashboardStatisticsDto>>> GetStatistics(
		CancellationToken cancellationToken){
		var result = await dashboardStatisticsQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<AdminDashboardStatisticsDto>.Ok(result));
	}

	/// <summary>
	///     获取后台最近一周 PV 访问量统计。
	/// </summary>
	[HttpGet("pv-statistics")]
	[ProducesResponseType(typeof(ApiResponse<AdminDashboardPvStatisticsDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<AdminDashboardPvStatisticsDto>>> GetPvStatistics(
		CancellationToken cancellationToken){
		var result = await dashboardPvStatisticsQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<AdminDashboardPvStatisticsDto>.Ok(result));
	}

	/// <summary>
	///     获取后台最近一年的文章发布统计。
	/// </summary>
	[HttpGet("publish-article-statistics")]
	[ProducesResponseType(typeof(ApiResponse<AdminDashboardPublishArticleStatisticsDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<AdminDashboardPublishArticleStatisticsDto>>> GetPublishArticleStatistics(
		CancellationToken cancellationToken){
		var result = await dashboardPublishArticleStatisticsQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<AdminDashboardPublishArticleStatisticsDto>.Ok(result));
	}
}