using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Message.Commands.PublishMessage;
using Mint.Blog.Application.Blog.Message.Queries.GetMessageList;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/message")]
public sealed class MessageController(
	IGetMessageListQueryService messageListQueryService,
	PublishMessageCommandHandler publishMessageCommandHandler) : ControllerBase {
	[HttpPost("list")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<MessageListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<MessageListItemDto>>>> GetList(
		[FromBody] GetMessageListRequest request,
		CancellationToken cancellationToken = default){
		var result =
			await messageListQueryService.GetAsync(
				new GetMessageListQuery(request.PageNumber, request.PageSize), cancellationToken);
		return Ok(ApiResponse<PagedResult<MessageListItemDto>>.Ok(result));
	}

	[HttpPost]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Publish([FromBody] PublishMessageCommand command,
		CancellationToken cancellationToken){
		var id = await publishMessageCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}
}

public sealed record GetMessageListRequest(
	int PageNumber = 1,
	int PageSize = 10);
