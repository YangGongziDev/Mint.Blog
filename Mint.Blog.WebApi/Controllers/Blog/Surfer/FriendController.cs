using System.Xml;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Friend;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Friend;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/friend")]
public sealed class FriendController(IFriendService friendService) : ControllerBase {
	[HttpGet("feed")]
	public async Task<ActionResult> GetFeed([FromQuery] string url, CancellationToken cancellationToken){
		try {
			var metadata = await friendService.ReadAsync(url, cancellationToken);
			return Ok(ApiResponse<object>.Ok(metadata));
		}
		catch (OperationCanceledException) when (!cancellationToken.IsCancellationRequested) {
			return BadRequest(ApiResponse<object>.Fail("feed_timeout", "订阅源解析超时，请手动填写或稍后重试"));
		}
		catch (Exception exception) when (exception is HttpRequestException or IOException or InvalidDataException or XmlException or ArgumentException) {
			return BadRequest(ApiResponse<object>.Fail("invalid_feed", "无法解析订阅源，请检查公网 RSS/Atom 链接，或手动填写"));
		}
	}

	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<PagedResult<FriendListItemVo>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<PagedResult<FriendListItemVo>>>> GetList(
		[FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10,
		CancellationToken cancellationToken = default){
		var result = await friendService.GetAsync(new GetFriendListQuery(pageNumber, pageSize), cancellationToken);
		return Ok(ApiResponse<PagedResult<FriendListItemVo>>.Ok(result));
	}

	[HttpGet("{friendId:long}")]
	[ProducesResponseType(typeof(ApiResponse<FriendDetailVo>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
	public async Task<ActionResult<ApiResponse<FriendDetailVo>>> GetDetail(long friendId, CancellationToken cancellationToken){
		var result = await friendService.GetAsync(new GetFriendDetailQuery(friendId), cancellationToken);
		return result is null
			? NotFound(ApiResponse<FriendDetailVo>.Fail(ErrorCodes.FriendNotFound, "Friend not found"))
			: Ok(ApiResponse<FriendDetailVo>.Ok(result));
	}

	[HttpPost]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Apply([FromBody] ApplyFriendCommand command, CancellationToken cancellationToken){
		var id = await friendService.ApplyAsync(command, cancellationToken);
		return Ok(ApiResponse<object>.Ok(new { id }));
	}
}
