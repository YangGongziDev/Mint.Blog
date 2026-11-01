using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Model.Vos;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Column;
using Mint.Blog.Model.Vos.Blog.Column;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/column")]
public sealed class ColumnController(IColumnService columnService) : ControllerBase {
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<BlogColumnListItemDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<IReadOnlyCollection<BlogColumnListItemDto>>>> GetList(CancellationToken cancellationToken) {
        var result = await columnService.GetAsync(cancellationToken);
        return Ok(ApiResponse<IReadOnlyCollection<BlogColumnListItemDto>>.Ok(result));
    }
    [HttpGet("{columnId:long}/catalog")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<BlogColumnCatalogItemDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<IReadOnlyCollection<BlogColumnCatalogItemDto>>>> GetCatalog(long columnId, CancellationToken cancellationToken) {
        var result = await columnService.GetAsync(new BlogColumnCatalogQuery(columnId), cancellationToken);
        return Ok(ApiResponse<IReadOnlyCollection<BlogColumnCatalogItemDto>>.Ok(result));
    }
    [HttpGet("{columnId:long}/article/{articleId:long}/neighbor")]
    [ProducesResponseType(typeof(ApiResponse<BlogColumnArticlePreNextDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<BlogColumnArticlePreNextDto>>> GetArticleNeighbors(long columnId, long articleId, CancellationToken cancellationToken) {
        var result = await columnService.GetAsync(new BlogColumnArticlePreNextQuery(columnId, articleId), cancellationToken);
        return Ok(ApiResponse<BlogColumnArticlePreNextDto>.Ok(result));
    }
    [HttpPost("catalog")]
    [ProducesResponseType(typeof(SurferResponse<IReadOnlyCollection<BlogColumnCatalogItemDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferResponse<IReadOnlyCollection<BlogColumnCatalogItemDto>>>> GetCatalogs([FromBody] SurferColumnCatalogRequest? request, CancellationToken cancellationToken) {
        if (request?.Id is null or <= 0) return Ok(SurferResponse<IReadOnlyCollection<BlogColumnCatalogItemDto>>.Ok([]));
        var result = await columnService.GetAsync(new BlogColumnCatalogQuery(request.Id.Value), cancellationToken);
        return Ok(SurferResponse<IReadOnlyCollection<BlogColumnCatalogItemDto>>.Ok(result));
    }
    [HttpPost("article/pre-next")]
    [ProducesResponseType(typeof(SurferResponse<BlogColumnArticlePreNextDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult<SurferResponse<BlogColumnArticlePreNextDto>>> GetArticlePreNext([FromBody] SurferColumnArticlePreNextRequest? request, CancellationToken cancellationToken) {
        if (request?.Id is null or <= 0 || request.ArticleId <= 0) return Ok(SurferResponse<BlogColumnArticlePreNextDto>.Ok(new BlogColumnArticlePreNextDto(null, null)));
        var result = await columnService.GetAsync(new BlogColumnArticlePreNextQuery(request.Id.Value, request.ArticleId), cancellationToken);
        return Ok(SurferResponse<BlogColumnArticlePreNextDto>.Ok(result));
    }
}
