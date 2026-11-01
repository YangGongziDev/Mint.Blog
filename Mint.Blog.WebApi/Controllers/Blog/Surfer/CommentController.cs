using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Model.Vos.Blog.Comment;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer")]
public sealed class CommentController(
	ICommentService commentService,
	IQqUserInfoService qqUserInfoQueryService) : ControllerBase {
	[HttpGet("comment/qq-user-info")]
	[ProducesResponseType(typeof(ApiResponse<QqUserInfoDto>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<QqUserInfoDto>>> GetQqUserInfo([FromQuery] string qq,
		CancellationToken cancellationToken){
		if (string.IsNullOrWhiteSpace(qq) || qq.Any(ch => !char.IsDigit(ch)))
			return BadRequest(ApiResponse<QqUserInfoDto>.Fail(ErrorCodes.QqNumberInvalid, "QQ 号格式不正确"));

		var result = await qqUserInfoQueryService.GetAsync(new GetQqUserInfoQuery(qq), cancellationToken);
		if (result is null) return Ok(ApiResponse<QqUserInfoDto>.Fail(ErrorCodes.UserNotFound, "获取 QQ 用户信息失败"));

		return Ok(ApiResponse<QqUserInfoDto>.Ok(result));
	}

	[HttpPost("comment")]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
	[ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
	public async Task<ActionResult<ApiResponse<object>>> Publish([FromBody] PublishCommentCommand command,
		CancellationToken cancellationToken){
		var result = await commentService.PublishAsync(command, cancellationToken);

		if (!result.IsSuccess) return BadRequest(ApiResponse<object>.Fail(result.ErrorCode!, result.Message!));

		return Ok(ApiResponse<object>.Ok(default(object?)));
	}

	[HttpGet("comment")]
	[ProducesResponseType(typeof(ApiResponse<CommentListDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<CommentListDto>>> Get([FromQuery] string routerUrl,
		CancellationToken cancellationToken){
		var result = await commentService.GetAsync(new GetCommentListQuery(routerUrl), cancellationToken);
		return Ok(ApiResponse<CommentListDto>.Ok(result));
	}

	[HttpPost("comment/publish")]
	[ProducesResponseType(typeof(SurferCommentResponse<object>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferCommentResponse<object>>> PublishForSurfer(
		[FromBody] SurferPublishCommentRequest request,
		CancellationToken cancellationToken){
		var command = new PublishCommentCommand(
			request.Avatar ?? string.Empty,
			request.Nickname ?? string.Empty,
			request.Mail ?? string.Empty,
			request.Website ?? string.Empty,
			request.RouterUrl ?? string.Empty,
			request.Content ?? string.Empty,
			ParseCommentId(request.ReplyCommentId),
			ParseCommentId(request.ParentCommentId));

		var result = await commentService.PublishAsync(command, cancellationToken);

		return Ok(result.IsSuccess
			? SurferCommentResponse<object>.Ok(null)
			: SurferCommentResponse<object>.Fail(result.Message ?? "评论发布失败", result.ErrorCode));
	}

	[HttpPost("comment/list")]
	[ProducesResponseType(typeof(SurferCommentResponse<SurferCommentListData>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferCommentResponse<SurferCommentListData>>> GetListForSurfer(
		[FromBody] SurferCommentListRequest? request,
		CancellationToken cancellationToken){
		var routerUrl = request?.RouterUrl ?? string.Empty;
		var result = await commentService.GetAsync(new GetCommentListQuery(routerUrl), cancellationToken);
		return Ok(SurferCommentResponse<SurferCommentListData>.Ok(ToSurferCommentListData(result)));
	}

	[HttpPost("comment/qq/userInfo")]
	[ProducesResponseType(typeof(SurferCommentResponse<QqUserInfoDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<SurferCommentResponse<QqUserInfoDto>>> GetQqUserInfoForSurfer(
		[FromBody] SurferQqUserInfoRequest? request,
		CancellationToken cancellationToken){
		var qq = request?.Qq?.Trim() ?? string.Empty;
		if (string.IsNullOrWhiteSpace(qq) || qq.Any(ch => !char.IsDigit(ch)))
			return Ok(SurferCommentResponse<QqUserInfoDto>.Fail("QQ 号格式不正确", ErrorCodes.QqNumberInvalid));

		var result = await qqUserInfoQueryService.GetAsync(new GetQqUserInfoQuery(qq), cancellationToken);
		return Ok(result is null
			? SurferCommentResponse<QqUserInfoDto>.Fail("获取 QQ 用户信息失败", ErrorCodes.UserNotFound)
			: SurferCommentResponse<QqUserInfoDto>.Ok(result));
	}

	private static SurferCommentListData ToSurferCommentListData(CommentListDto source){
		return new SurferCommentListData(source.Total, source.Comments?.Select(ToSurferCommentItem).ToArray() ?? []);
	}

	private static SurferCommentItem ToSurferCommentItem(CommentItemDto source){
		return new SurferCommentItem(
			source.Id.ToString(),
			source.Avatar,
			source.Nickname,
			source.Website,
			source.Content,
			source.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss"),
			source.ReplyNickname,
			source.ChildComments.Select(ToSurferCommentItem).ToArray(),
			source.IsShowReplyForm);
	}

	private static long? ParseCommentId(JsonElement? value){
		if (value is null) return null;

		return value.Value.ValueKind switch {
			JsonValueKind.Number when value.Value.TryGetInt64(out var id) => id,
			JsonValueKind.String when long.TryParse(value.Value.GetString(), out var id) => id,
			_ => null
		};
	}
}
