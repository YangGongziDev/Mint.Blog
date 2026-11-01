using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Setting;
using Mint.Blog.Model.Vos.Blog.Statistics;
using Mint.Blog.Model.Vos.Blog.Column;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
public sealed class SidebarController(
    IBlogSettingService blogSettingsDetailQueryService,
    IStatisticsService blogStatisticsQueryService,
    ICategoryService categoryListQueryService,
    ITagService tagListQueryService,
    IColumnService blogColumnListQueryService) : ControllerBase {
    [HttpPost("api/surfer/setting/detail")]
    [ProducesResponseType(typeof(SurferResponse<BlogSettingsDetailVo>), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferResponse<BlogSettingsDetailVo>>> GetSettings(CancellationToken cancellationToken) {
        var result = await blogSettingsDetailQueryService.GetAsync(cancellationToken);
        return Ok(SurferResponse<BlogSettingsDetailVo>.Ok(result));
    }

    [HttpPost("api/surfer/statistics/info")]
    [ProducesResponseType(typeof(SurferResponse<BlogStatisticsDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferResponse<BlogStatisticsDto>>> GetStatistics(CancellationToken cancellationToken) {
        var result = await blogStatisticsQueryService.GetBlogAsync(cancellationToken);
        return Ok(SurferResponse<BlogStatisticsDto>.Ok(result));
    }

    [HttpPost("api/surfer/category/list")]
    [ProducesResponseType(typeof(SurferResponse<IReadOnlyCollection<SurferCategoryListItem>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferResponse<IReadOnlyCollection<SurferCategoryListItem>>>> GetCategories(CancellationToken cancellationToken) {
        var result = await categoryListQueryService.GetAsync(cancellationToken);
        return Ok(SurferResponse<IReadOnlyCollection<SurferCategoryListItem>>.Ok(result.Select(item => new SurferCategoryListItem(item.Id, item.Name, item.ArticlesTotal, item.Sort)).ToArray()));
    }

    [HttpPost("api/surfer/tag/list")]
    [ProducesResponseType(typeof(SurferResponse<IReadOnlyCollection<SurferTagListItem>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferResponse<IReadOnlyCollection<SurferTagListItem>>>> GetTags(CancellationToken cancellationToken) {
        var result = await tagListQueryService.GetAsync(cancellationToken);
        return Ok(SurferResponse<IReadOnlyCollection<SurferTagListItem>>.Ok(result.Select(item => new SurferTagListItem(item.Id, item.Name, item.ArticlesTotal, item.Sort)).ToArray()));
    }

    [HttpPost("api/surfer/column/list")]
    [ProducesResponseType(typeof(SurferResponse<IReadOnlyCollection<BlogColumnListItemDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferResponse<IReadOnlyCollection<BlogColumnListItemDto>>>> GetColumns(CancellationToken cancellationToken) {
        var result = await blogColumnListQueryService.GetAsync(cancellationToken);
        return Ok(SurferResponse<IReadOnlyCollection<BlogColumnListItemDto>>.Ok(result));
    }
}
