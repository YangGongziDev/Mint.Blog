using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Message;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Message;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/message")]
public sealed class MessageController(IMessageService messageService) : ControllerBase {
	[HttpPost("list")]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<MessageListItemVo>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<MessageListItemVo>>>> GetList(
		[FromBody] GetMessageListRequest request,
		CancellationToken cancellationToken = default){
		var result = await messageService.GetAsync(request, cancellationToken);
		return Ok(ApiResponse<PagedResult<MessageListItemVo>>.Ok(result));
	}

	[HttpPost]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Publish([FromBody] PublishMessageCommand command,
		CancellationToken cancellationToken){
		var id = await messageService.PublishAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}
}
