using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Commands.CreateArticle;
using Mint.Blog.Application.Blog.Article.Commands.DeleteArticle;
using Mint.Blog.Application.Blog.Article.Commands.SetArticleTop;
using Mint.Blog.Application.Blog.Article.Commands.UpdateArticle;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleDetail;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize]
[Route("api/blog/admin/article")]
public sealed class ArticleController(
	IGetArticleListQueryService articleListQueryService,
	IGetArticleDetailQueryService articleDetailQueryService,
	CreateArticleCommandHandler createArticleCommandHandler,
	UpdateArticleCommandHandler updateArticleCommandHandler,
	DeleteArticleCommandHandler deleteArticleCommandHandler,
	SetArticleTopCommandHandler setArticleTopCommandHandler) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<ArticleListItemDto>>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult> GetList(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		[FromQuery] long? categoryId = null,
		[FromQuery] long? tagId = null,
		[FromQuery] string? title = null,
		[FromQuery] DateOnly? startDate = null,
		[FromQuery] DateOnly? endDate = null,
		CancellationToken cancellationToken = default){
		var result = await articleListQueryService.GetAsync(
			new ArticleListQuery(pageNumber, pageSize, categoryId, tagId, title, startDate, endDate),
			cancellationToken);
		var response = new PagedResult<object>(
			result.Items.Select(item => new {
				id = item.Id.ToString(),
				item.Title,
				item.Summary,
				item.Cover,
				item.CategoryId,
				item.CategoryName,
				item.Tags,
				item.IsTop,
				item.IsDeleted,
				item.ReadCount,
				item.CreatedAt,
				item.CreateTime
			}).ToArray(),
			result.PageNumber,
			result.PageSize,
			result.TotalCount);

		return Ok(ApiResponse<PagedResult<object>>.Ok(response));
	}

	[HttpGet("{articleId:long}")]
	[ProducesResponseType(typeof(ApiResponse<ArticleDetailDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult> GetDetail(long articleId,
		CancellationToken cancellationToken){
		var article = await articleDetailQueryService.GetAsync(new ArticleDetailQuery(articleId), cancellationToken);
		return article is null
			? NotFound(ApiResponse<object>.Fail(ErrorCodes.ArticleNotFound, "Article not found"))
			: Ok(ApiResponse<object>.Ok(new {
				id = article.Id.ToString(),
				article.Title,
				article.Summary,
				article.Content,
				article.Cover,
				article.CategoryId,
				article.CategoryName,
				article.Tags,
				article.IsTop,
				article.ReadCount,
				article.CreatedAt,
				article.UpdatedAt
			}));
	}

	[HttpPost]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Create([FromBody] CreateArticleCommand command,
		CancellationToken cancellationToken){
		var articleId = await createArticleCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = articleId.ToString() }));
	}

	[HttpPut("{articleId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Update(long articleId, [FromBody] UpdateArticleCommand command,
		CancellationToken cancellationToken){
		await updateArticleCommandHandler.HandleAsync(command with { ArticleId = articleId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = articleId.ToString() }));
	}

	[HttpPatch("{articleId:long}/top")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> SetTop(long articleId, [FromBody] SetArticleTopCommand command,
		CancellationToken cancellationToken){
		await setArticleTopCommandHandler.HandleAsync(command with { ArticleId = articleId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = articleId, isTop = command.IsTop }));
	}

	[HttpDelete("{articleId:long}")]
	[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
	public async Task<ActionResult<ApiResponse<object>>> Delete(long articleId, [FromBody] DeleteArticleCommand command,
		CancellationToken cancellationToken){
		await deleteArticleCommandHandler.HandleAsync(command with { ArticleId = articleId }, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id = articleId, deleteType = command.DeleteType }));
	}
}
