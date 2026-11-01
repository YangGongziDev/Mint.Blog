using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/admin/articles")]
public sealed class ArticleController(IArticleService articles) : ControllerBase {
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<PagedResult<ArticleListItemDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult> GetList(
        [FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10,
        [FromQuery] long? categoryId = null, [FromQuery] long? tagId = null,
        [FromQuery] string? title = null, [FromQuery] DateOnly? startDate = null,
        [FromQuery] DateOnly? endDate = null, [FromQuery] string? sortOrder = null,
        [FromQuery] long? tagVersionId = null, CancellationToken cancellationToken = default) {
        Guard.Against(Request.Query.ContainsKey("versionId"), "legacy_contract", "请升级客户端，版本筛选参数已改为 tagVersionId。");
        var result = await articles.GetAsync(
            new ArticleListQuery(pageNumber, pageSize, categoryId, tagId, title, startDate, endDate, sortOrder,
                IncludeColumnOnly: true, TagVersionId: tagVersionId), cancellationToken);
        return Ok(ApiResponse<PagedResult<ArticleListItemDto>>.Ok(result));
    }

    [HttpGet("{articleId:long}")]
    [ProducesResponseType(typeof(ApiResponse<ArticleDetailDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult> GetDetail(long articleId, CancellationToken cancellationToken) {
        var article = await articles.GetAsync(new ArticleDetailQuery(articleId, ForAdmin: true), cancellationToken);
        return article is null
            ? NotFound(ApiResponse<object>.Fail(ErrorCodes.ArticleNotFound, "Article not found"))
            : Ok(ApiResponse<ArticleDetailDto>.Ok(article));
    }

    [HttpPost]
    [Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
    public async Task<ActionResult<ApiResponse<object>>> Create([FromBody] CreateArticleCommand command, CancellationToken cancellationToken) {
        var articleId = await articles.CreateAsync(command, cancellationToken);
        return Ok(ApiResponse<object>.Ok(new { id = articleId.ToString() }));
    }

    [HttpPut("{articleId:long}")]
    [Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
    public async Task<ActionResult<ApiResponse<object>>> Update(long articleId, [FromBody] UpdateArticleCommand command, CancellationToken cancellationToken) {
        await articles.UpdateAsync(command with { ArticleId = articleId }, cancellationToken);
        return Ok(ApiResponse<object>.Ok(new { id = articleId.ToString() }));
    }

    [HttpPatch("{articleId:long}")]
    [Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
    public async Task<ActionResult<ApiResponse<object>>> Patch(long articleId, [FromBody] PatchArticleCommand command, CancellationToken cancellationToken) {
        await articles.PatchAsync(command with { ArticleId = articleId }, cancellationToken);
        var result = new Dictionary<string, object> { ["id"] = articleId.ToString() };
        if (command.HasIsTop) result["isTop"] = command.IsTop!.Value;
        if (command.HasVisibility) result["visibility"] = command.Visibility!.Value;
        return Ok(ApiResponse<object>.Ok(result));
    }

    [HttpDelete("{articleId:long}")]
    [Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
    public async Task<ActionResult<ApiResponse<object>>> Delete(long articleId, CancellationToken cancellationToken, [FromQuery] long deleteType = 1) {
        await articles.DeleteAsync(new DeleteArticleCommand(articleId, deleteType), cancellationToken);
        return Ok(ApiResponse<object>.Ok(new { id = articleId, deleteType }));
    }
}
