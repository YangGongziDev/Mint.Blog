using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/archive")]
public sealed class ArchiveController(IPublicArticleService service) : ControllerBase {
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<PagedResult<ArchiveMonthGroupDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<PagedResult<ArchiveMonthGroupDto>>>> GetPageList(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        CancellationToken cancellationToken = default) {
        var result = await service.GetArchivePageAsync(new GetArchivePageListQuery(pageNumber, pageSize), cancellationToken);
        return Ok(ApiResponse<PagedResult<ArchiveMonthGroupDto>>.Ok(result));
    }

    [HttpGet("year")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<ArchiveYearDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<IReadOnlyCollection<ArchiveYearDto>>>> GetYears(CancellationToken cancellationToken) {
        var result = await service.GetArchiveYearsAsync(cancellationToken);
        return Ok(ApiResponse<IReadOnlyCollection<ArchiveYearDto>>.Ok(result));
    }

    [HttpGet("{year:int}")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<ArchiveMonthGroupDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<IReadOnlyCollection<ArchiveMonthGroupDto>>>> GetYear(int year, CancellationToken cancellationToken) {
        var result = await service.GetArchiveYearAsync(new GetArchiveYearListQuery(year), cancellationToken);
        return Ok(ApiResponse<IReadOnlyCollection<ArchiveMonthGroupDto>>.Ok(result));
    }

    [HttpPost("list")]
    [ProducesResponseType(typeof(SurferArchivePageResponse), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferArchivePageResponse>> GetList(
        [FromBody] SurferArchivePageRequest? request,
        CancellationToken cancellationToken = default) {
        return Ok(await service.GetArchiveAsync(request, cancellationToken));
    }

    [HttpPost("year")]
    [ProducesResponseType(typeof(SurferArchiveYearsResponse), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferArchiveYearsResponse>> GetYearsForSurfer(CancellationToken cancellationToken) {
        var result = await service.GetArchiveYearsAsync(cancellationToken);
        return Ok(new SurferArchiveYearsResponse(true, result));
    }
}
