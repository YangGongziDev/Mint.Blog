using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Service.IService.Blog;
using static Mint.Blog.Model.Vos.Blog.Article.ArticleResponseMapping;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/article")]
public sealed class ArticleController(IArticleService articles) : ControllerBase {
    [HttpGet]
    public async Task<ActionResult<ApiResponse<PagedResult<ArticleListItemDto>>>> GetList(
        [FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10,
        [FromQuery] long? categoryId = null, [FromQuery] long? tagId = null,
        [FromQuery] long? tagVersionId = null, CancellationToken cancellationToken = default) {
        Guard.Against(Request.Query.ContainsKey("versionId"), "legacy_contract", "请使用 tagVersionId 参数。");
        var result = await articles.GetAsync(new ArticleListQuery(pageNumber, pageSize, categoryId, tagId, TagVersionId: tagVersionId), cancellationToken);
        return Ok(ApiResponse<PagedResult<ArticleListItemDto>>.Ok(result));
    }

    [HttpGet("search")]
    public async Task<ActionResult<ApiResponse<PagedResult<SearchArticleItemDto>>>> Search(
        [FromQuery] string keyword, [FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10,
        CancellationToken cancellationToken = default) {
        if (string.IsNullOrWhiteSpace(keyword))
            return BadRequest(ApiResponse<PagedResult<SearchArticleItemDto>>.Fail(ErrorCodes.ArticleSearchKeywordInvalid, "Search keyword is required."));
        var result = await articles.GetAsync(new SearchArticlesQuery(keyword, pageNumber, pageSize), cancellationToken);
        return Ok(ApiResponse<PagedResult<SearchArticleItemDto>>.Ok(result));
    }

    [HttpGet("{articleId:long}")]
    public async Task<ActionResult<ApiResponse<ArticleDetailDto>>> GetDetail(long articleId,
        CancellationToken cancellationToken, [FromQuery] long? columnId = null) {
        var article = await articles.GetAsync(new ArticleDetailQuery(articleId, columnId), cancellationToken);
        return article is null
            ? NotFound(ApiResponse<ArticleDetailDto>.Fail(ErrorCodes.ArticleNotFound, "Article not found"))
            : Ok(ApiResponse<ArticleDetailDto>.Ok(article));
    }

    [HttpPost("list")]
    public async Task<ActionResult<SurferArticlePageResponse>> GetListForSurfer(
        [FromBody] SurferArticlePageRequest? request, CancellationToken cancellationToken = default) =>
        await QueryArticlesAsync(request, request?.CategoryId, request?.TagId, cancellationToken);

    [HttpPost("detail")]
    public async Task<ActionResult<SurferArticleDetailResponse>> GetDetailForSurfer(
        [FromBody] SurferArticleDetailRequest? request, CancellationToken cancellationToken = default) {
        if (string.IsNullOrWhiteSpace(request?.ArticleId) || !long.TryParse(request.ArticleId, out var articleId))
            return Ok(new SurferArticleDetailResponse(false, null, "20010", "文章不存在"));
        var article = await articles.GetAsync(new ArticleDetailQuery(articleId, request.ColumnId), cancellationToken);
        return article is null
            ? Ok(new SurferArticleDetailResponse(false, null, "20010", "文章不存在"))
            : Ok(new SurferArticleDetailResponse(true, ToSurferArticleDetail(article)));
    }

    [HttpPost("~/api/surfer/category/article/list")]
    public async Task<ActionResult<SurferArticlePageResponse>> GetCategoryArticles(
        [FromBody] SurferScopedArticlePageRequest? request, CancellationToken cancellationToken = default) =>
        await QueryArticlesAsync(request, request?.ScopedId, null, cancellationToken);

    [HttpPost("~/api/surfer/tag/article/list")]
    public async Task<ActionResult<SurferArticlePageResponse>> GetTagArticles(
        [FromBody] SurferScopedArticlePageRequest? request, CancellationToken cancellationToken = default) =>
        await QueryArticlesAsync(request, null, request?.ScopedId, cancellationToken);

    private async Task<ActionResult<SurferArticlePageResponse>> QueryArticlesAsync(
        IArticlePageRequest? request, long? categoryId, long? tagId, CancellationToken cancellationToken) {
        var current = request?.Current <= 0 ? 1 : request?.Current ?? 1;
        var size = request?.Size <= 0 ? 10 : request?.Size ?? 10;
        var result = await articles.GetAsync(new ArticleListQuery(current, size, categoryId, tagId, TagVersionId: request?.TagVersionId), cancellationToken);
        return Ok(new SurferArticlePageResponse(true, result.Items.Select(ToSurferArticle).ToArray(),
            result.PageNumber, result.PageSize, result.TotalCount, (int)Math.Ceiling(result.TotalCount / (double)result.PageSize)));
    }
}

public sealed record SurferCategory(long Id, string Name, int ArticlesTotal);
public sealed record SurferTag(long Id, string Name);
