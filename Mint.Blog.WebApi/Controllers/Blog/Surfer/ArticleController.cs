using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleDetail;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Article.Queries.SearchArticles;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/article")]
public sealed class ArticleController(
	IGetArticleListQueryService articleListQueryService,
	IGetArticleDetailQueryService articleDetailQueryService,
	ISearchArticlesQueryService searchArticlesQueryService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<ArticleListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<ArticleListItemDto>>>> GetList(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		[FromQuery] long? categoryId = null,
		[FromQuery] long? tagId = null,
		CancellationToken cancellationToken = default){
		var query = new ArticleListQuery(pageNumber, pageSize, categoryId, tagId);
		var articles = await articleListQueryService.GetAsync(query, cancellationToken);
		return Ok(ApiResponse<PagedResult<ArticleListItemDto>>.Ok(articles));
	}

	[HttpGet("search")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<SearchArticleItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<PagedResult<SearchArticleItemDto>>>> Search(
		[FromQuery] string keyword,
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(keyword))
			return BadRequest(ApiResponse<PagedResult<SearchArticleItemDto>>.Fail(ErrorCodes.ArticleSearchKeywordInvalid,
				"Search keyword is required."));

		var result = await searchArticlesQueryService.GetAsync(new SearchArticlesQuery(keyword, pageNumber, pageSize),
			cancellationToken);
		return Ok(ApiResponse<PagedResult<SearchArticleItemDto>>.Ok(result));
	}

	[HttpGet("{articleId:long}")]
	[ProducesResponseType(typeof(ApiResponse<ArticleDetailDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
	public async Task<ActionResult<ApiResponse<ArticleDetailDto>>> GetDetail(long articleId,
		CancellationToken cancellationToken){
		var article = await articleDetailQueryService.GetAsync(new ArticleDetailQuery(articleId), cancellationToken);
		return article is null
			? NotFound(ApiResponse<ArticleDetailDto>.Fail(ErrorCodes.ArticleNotFound, "Article not found"))
			: Ok(ApiResponse<ArticleDetailDto>.Ok(article));
	}

	[HttpPost("list")]
	[ProducesResponseType(typeof(SurferArticlePageResponse), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferArticlePageResponse>> GetListForSurfer(
		[FromBody] SurferArticlePageRequest? request,
		CancellationToken cancellationToken = default){
		return await QueryArticlesAsync(request, request?.CategoryId, request?.TagId, cancellationToken);
	}

	[HttpPost("detail")]
	[ProducesResponseType(typeof(SurferArticleDetailResponse), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferArticleDetailResponse>> GetDetailForSurfer(
		[FromBody] SurferArticleDetailRequest? request,
		CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(request?.ArticleId) || !long.TryParse(request.ArticleId, out var articleId))
			return Ok(new SurferArticleDetailResponse(false, null, "20010", "文章不存在"));

		var article = await articleDetailQueryService.GetAsync(new ArticleDetailQuery(articleId),
			cancellationToken);
		if (article is null)
			return Ok(new SurferArticleDetailResponse(false, null, "20010", "文章不存在"));

		return Ok(new SurferArticleDetailResponse(true, ToSurferArticleDetail(article)));
	}

	[HttpPost("api/blog/surfer/category/article/list")]
	[ProducesResponseType(typeof(SurferArticlePageResponse), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferArticlePageResponse>> GetCategoryArticles(
		[FromBody] SurferScopedArticlePageRequest? request,
		CancellationToken cancellationToken = default){
		return await QueryArticlesAsync(request, request?.ScopedId, null, cancellationToken);
	}

	[HttpPost("api/blog/surfer/tag/article/list")]
	[ProducesResponseType(typeof(SurferArticlePageResponse), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferArticlePageResponse>> GetTagArticles(
		[FromBody] SurferScopedArticlePageRequest? request,
		CancellationToken cancellationToken = default){
		return await QueryArticlesAsync(request, null, request?.ScopedId, cancellationToken);
	}

	private async Task<ActionResult<SurferArticlePageResponse>> QueryArticlesAsync(
		IArticlePageRequest? request,
		long? categoryId,
		long? tagId,
		CancellationToken cancellationToken){
		var current = request?.Current <= 0 ? 1 : request?.Current ?? 1;
		var size = request?.Size <= 0 ? 10 : request?.Size ?? 10;

		var result = await articleListQueryService.GetAsync(
			new ArticleListQuery(current, size, categoryId, tagId),
			cancellationToken);

		return Ok(new SurferArticlePageResponse(
			true,
			result.Items.Select(ToSurferArticle).ToArray(),
			result.PageNumber,
			result.PageSize,
			result.TotalCount,
			(int)Math.Ceiling(result.TotalCount / (double)result.PageSize)));
	}

	private static SurferArticleItem ToSurferArticle(ArticleListItemDto item){
		return new SurferArticleItem(
			item.Id.ToString(),
			item.Title,
			item.Summary,
			item.Cover,
			item.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss"),
			item.IsTop,
			item.ReadCount,
			new SurferCategory(item.CategoryId, item.CategoryName, 0),
			item.Tags.Select(tag => new SurferTag(tag.Id, tag.Name)).ToArray());
	}

	private static SurferArticleDetail ToSurferArticleDetail(ArticleDetailDto item){
		var plainTextLength = item.Content.Length;
		var readMinutes = Math.Max(1, (int)Math.Ceiling(plainTextLength / 500.0));

		return new SurferArticleDetail(
			item.Id.ToString(),
			item.Title,
			item.Summary,
			item.Content,
			item.Cover,
			item.Tags.Select(tag => new SurferTag(tag.Id, tag.Name)).ToArray(),
			plainTextLength,
			$"{readMinutes} 分钟",
			item.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss"),
			item.UpdatedAt.ToString("yyyy-MM-dd HH:mm:ss"),
			item.CategoryId,
			item.CategoryName,
			item.ReadCount,
			null,
			null);
	}
}

public interface IArticlePageRequest {
	int Current { get; }
	int Size { get; }
}

public sealed record SurferArticlePageRequest(int Current = 1, int Size = 10, long? CategoryId = null, long? TagId = null)
	: IArticlePageRequest;

public sealed record SurferScopedArticlePageRequest(
	int Current = 1,
	int Size = 10,
	long? Id = null,
	long? CategoryId = null,
	long? TagId = null) : IArticlePageRequest {
	public long? ScopedId => Id ?? CategoryId ?? TagId;
}

public sealed record SurferArticleDetailRequest(string? ArticleId);

public sealed record SurferArticlePageResponse(
	bool Success,
	IReadOnlyCollection<SurferArticleItem> Data,
	int Current,
	int Size,
	int Total,
	int Pages);

public sealed record SurferArticleDetailResponse(
	bool Success,
	SurferArticleDetail? Data,
	string? ErrorCode = null,
	string? Message = null);

public sealed record SurferArticleItem(
	string Id,
	string Title,
	string Summary,
	string Cover,
	string CreateDate,
	bool IsTop,
	long ReadNum,
	SurferCategory Category,
	IReadOnlyCollection<SurferTag> Tags);

public sealed record SurferArticleDetail(
	string Id,
	string Title,
	string Summary,
	string Content,
	string Cover,
	IReadOnlyCollection<SurferTag> Tags,
	int TotalWords,
	string ReadTime,
	string CreateTime,
	string UpdateTime,
	long CategoryId,
	string CategoryName,
	long ReadNum,
	SurferAdjacentArticle? PreArticle,
	SurferAdjacentArticle? NextArticle);

public sealed record SurferAdjacentArticle(long ArticleId, string ArticleTitle);

public sealed record SurferCategory(long Id, string Name, int ArticlesTotal);

public sealed record SurferTag(long Id, string Name);