using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;
using Mint.Blog.Application.Blog.Article.Queries.GetArchiveYearList;
using Mint.Blog.Application.Blog.Article.Queries.GetArchiveYears;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/archive")]
public sealed class ArchiveController(
	IGetArchivePageListQueryService archivePageListQueryService,
	IGetArchiveYearListQueryService archiveYearListQueryService,
	IGetArchiveYearsQueryService archiveYearsQueryService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<ArchiveMonthGroupDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<ArchiveMonthGroupDto>>>> GetPageList(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		CancellationToken cancellationToken = default){
		var result =
			await archivePageListQueryService.GetAsync(new GetArchivePageListQuery(pageNumber, pageSize),
				cancellationToken);
		return Ok(ApiResponse<PagedResult<ArchiveMonthGroupDto>>.Ok(result));
	}

	[HttpGet("year")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<ArchiveYearDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<ArchiveYearDto>>>>
		GetYears(CancellationToken cancellationToken){
		var result = await archiveYearsQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<ArchiveYearDto>>.Ok(result));
	}

	[HttpGet("{year:int}")]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<ArchiveMonthGroupDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<ArchiveMonthGroupDto>>>> GetYear(int year,
		CancellationToken cancellationToken){
		var result = await archiveYearListQueryService.GetAsync(new GetArchiveYearListQuery(year), cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<ArchiveMonthGroupDto>>.Ok(result));
	}

	[HttpPost("list")]
	[ProducesResponseType(typeof(SurferArchivePageResponse), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferArchivePageResponse>> GetList(
		[FromBody] SurferArchivePageRequest? request,
		CancellationToken cancellationToken = default){
		var current = request?.Current <= 0 ? 1 : request?.Current ?? 1;
		var size = request?.Size <= 0 ? 20 : request?.Size ?? 20;

		if (int.TryParse(request?.Year, out var year) && year > 0) {
			var yearGroups = await archiveYearListQueryService.GetAsync(new GetArchiveYearListQuery(year), cancellationToken);
			var groups = yearGroups.Select(ToSurferArchiveMonth).ToArray();
			return Ok(new SurferArchivePageResponse(true, groups, 1, size, groups.Sum(x => x.Articles.Count), 1));
		}

		var result = await archivePageListQueryService.GetAsync(new GetArchivePageListQuery(current, size), cancellationToken);
		return Ok(new SurferArchivePageResponse(
			true,
			result.Items.Select(ToSurferArchiveMonth).ToArray(),
			result.PageNumber,
			result.PageSize,
			result.TotalCount,
			(int)Math.Ceiling(result.TotalCount / (double)result.PageSize)));
	}

	[HttpPost("year")]
	[ProducesResponseType(typeof(SurferArchiveYearsResponse), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferArchiveYearsResponse>> GetYearsForSurfer(CancellationToken cancellationToken){
		var result = await archiveYearsQueryService.GetAsync(cancellationToken);
		return Ok(new SurferArchiveYearsResponse(true, result));
	}

	private static SurferArchiveMonth ToSurferArchiveMonth(ArchiveMonthGroupDto group){
		return new SurferArchiveMonth(group.Month,
			group.Articles.Select(article => new SurferArchiveArticle(
				article.Id,
				article.Title,
				article.Cover,
				article.CreatedDate.ToString("yyyy-MM-dd"))).ToArray());
	}
}

public sealed record SurferArchivePageRequest(int Current = 1, int Size = 20, string? Year = null);

public sealed record SurferArchivePageResponse(
	bool Success,
	IReadOnlyCollection<SurferArchiveMonth> Data,
	int Current,
	int Size,
	int Total,
	int Pages);

public sealed record SurferArchiveYearsResponse(bool Success, IReadOnlyCollection<ArchiveYearDto> Data);

public sealed record SurferArchiveMonth(string Month, IReadOnlyCollection<SurferArchiveArticle> Articles);

public sealed record SurferArchiveArticle(long Id, string Title, string Cover, string CreateDate);