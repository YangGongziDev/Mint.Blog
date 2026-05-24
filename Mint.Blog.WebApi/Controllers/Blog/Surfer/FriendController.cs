using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Friend.Commands.ApplyFriend;
using Mint.Blog.Application.Blog.Friend.Queries.GetFriendDetail;
using Mint.Blog.Application.Blog.Friend.Queries.GetFriendList;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/friend")]
public sealed class FriendController(
	IGetFriendListQueryService friendListQueryService,
	IGetFriendDetailQueryService friendDetailQueryService,
	ApplyFriendCommandHandler applyFriendCommandHandler) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<FriendListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<FriendListItemDto>>>> GetList(
		[FromQuery] int pageNumber = 1,
		[FromQuery] int pageSize = 10,
		CancellationToken cancellationToken = default){
		var result =
			await friendListQueryService.GetAsync(new GetFriendListQuery(pageNumber, pageSize), cancellationToken);
		return Ok(ApiResponse<PagedResult<FriendListItemDto>>.Ok(result));
	}

	[HttpGet("{friendId:long}")]
	[ProducesResponseType(typeof(ApiResponse<FriendDetailDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
	public async Task<ActionResult<ApiResponse<FriendDetailDto>>> GetDetail(long friendId,
		CancellationToken cancellationToken){
		var result = await friendDetailQueryService.GetAsync(new GetFriendDetailQuery(friendId), cancellationToken);
		return result is null
			? NotFound(ApiResponse<FriendDetailDto>.Fail(ErrorCodes.FriendNotFound, "Friend not found"))
			: Ok(ApiResponse<FriendDetailDto>.Ok(result));
	}

	[HttpPost]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Apply([FromBody] ApplyFriendCommand command,
		CancellationToken cancellationToken){
		var id = await applyFriendCommandHandler.HandleAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}
}