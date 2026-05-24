using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Blog.Setting.Queries.GetBlogSettingsDetail;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;
using Mint.Blog.Application.Blog.Statistics.Queries.GetBlogStatistics;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagList;
using Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnList;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
public sealed class SidebarController(
	IGetBlogSettingsDetailQueryService blogSettingsDetailQueryService,
	IGetBlogStatisticsQueryService blogStatisticsQueryService,
	IGetCategoryListQueryService categoryListQueryService,
	IGetTagListQueryService tagListQueryService,
	IGetBlogColumnListQueryService blogColumnListQueryService) : ControllerBase {
	[HttpPost("api/blog/surfer/blog/setting/detail")]
	[ProducesResponseType(typeof(SurferResponse<BlogSettingsDetailDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferResponse<BlogSettingsDetailDto>>> GetSettings(
		CancellationToken cancellationToken){
		var result = await blogSettingsDetailQueryService.GetAsync(cancellationToken);
		return Ok(SurferResponse<BlogSettingsDetailDto>.Ok(result));
	}

	[HttpPost("api/blog/surfer/statistics/info")]
	[ProducesResponseType(typeof(SurferResponse<BlogStatisticsDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferResponse<BlogStatisticsDto>>> GetStatistics(
		CancellationToken cancellationToken){
		var result = await blogStatisticsQueryService.GetAsync(cancellationToken);
		return Ok(SurferResponse<BlogStatisticsDto>.Ok(result));
	}

	[HttpPost("api/blog/surfer/category/list")]
	[ProducesResponseType(typeof(SurferResponse<IReadOnlyCollection<SurferCategoryListItem>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferResponse<IReadOnlyCollection<SurferCategoryListItem>>>> GetCategories(
		CancellationToken cancellationToken){
		var result = await categoryListQueryService.GetAsync(cancellationToken);
		return Ok(SurferResponse<IReadOnlyCollection<SurferCategoryListItem>>.Ok(
			result.Select(item => new SurferCategoryListItem(item.Id, item.Name, item.ArticlesTotal, item.Sort)).ToArray()));
	}

	[HttpPost("api/blog/surfer/tag/list")]
	[ProducesResponseType(typeof(SurferResponse<IReadOnlyCollection<SurferTagListItem>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferResponse<IReadOnlyCollection<SurferTagListItem>>>> GetTags(
		CancellationToken cancellationToken){
		var result = await tagListQueryService.GetAsync(cancellationToken);
		return Ok(SurferResponse<IReadOnlyCollection<SurferTagListItem>>.Ok(
			result.Select(item => new SurferTagListItem(item.Id, item.Name, item.ArticlesTotal, item.Sort)).ToArray()));
	}

	[HttpPost("api/blog/surfer/column/list")]
	[ProducesResponseType(typeof(SurferResponse<IReadOnlyCollection<BlogColumnListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferResponse<IReadOnlyCollection<BlogColumnListItemDto>>>> GetColumns(
		CancellationToken cancellationToken){
		var result = await blogColumnListQueryService.GetAsync(cancellationToken);
		return Ok(SurferResponse<IReadOnlyCollection<BlogColumnListItemDto>>.Ok(result));
	}
}

public sealed record SurferResponse<T>(bool Success, T? Data, string? Message = null) {
	public static SurferResponse<T> Ok(T? data, string? message = null) => new(true, data, message);
}

public sealed record SurferCategoryListItem(long Id, string Name, int ArticlesTotal, long? Sort = 0);

public sealed record SurferTagListItem(long Id, string Name, int ArticlesTotal, long? Sort = 0);
