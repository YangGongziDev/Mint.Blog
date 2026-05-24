using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Drafts;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/article-draft")]
public sealed class ArticleDraftController(IArticleDraftService articleDraftService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<ArticleDraftListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<ArticleDraftListItemDto>>>> GetList(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 20,
		CancellationToken cancellationToken = default){
		var result = await articleDraftService.GetListAsync(pageNumber, pageSize, cancellationToken);
		return Ok(ApiResponse<PagedResult<ArticleDraftListItemDto>>.Ok(result));
	}

	[HttpGet("{draftId:long}")]
	[ProducesResponseType(typeof(ApiResponse<ArticleDraftDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
	public async Task<ActionResult<ApiResponse<ArticleDraftDto>>> GetDetail(long draftId,
		CancellationToken cancellationToken){
		var draft = await articleDraftService.GetByIdAsync(draftId, cancellationToken);
		return draft is null
			? NotFound(ApiResponse<ArticleDraftDto>.Fail(ErrorCodes.ArticleDraftNotFound, "Article draft not found"))
			: Ok(ApiResponse<ArticleDraftDto>.Ok(draft));
	}

	[HttpGet("by-article/{articleId:long}")]
	[ProducesResponseType(typeof(ApiResponse<ArticleDraftDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<ArticleDraftDto?>>> GetByArticleId(long articleId,
		CancellationToken cancellationToken){
		var draft = await articleDraftService.GetByArticleIdAsync(articleId, cancellationToken);
		return Ok(ApiResponse<ArticleDraftDto?>.Ok(draft));
	}

	[HttpPost]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Save([FromBody] SaveArticleDraftCommand command,
		CancellationToken cancellationToken){
		var draftId = await articleDraftService.SaveAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = draftId.ToString() }));
	}

	[HttpPost("{draftId:long}/publish")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Publish(long draftId, CancellationToken cancellationToken){
		var articleId = await articleDraftService.PublishAsync(draftId, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = articleId.ToString() }));
	}

	[HttpDelete("{draftId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long draftId, CancellationToken cancellationToken){
		await articleDraftService.DeleteAsync(draftId, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = draftId }));
	}
}
