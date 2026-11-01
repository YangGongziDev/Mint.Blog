using System.Text.Json.Serialization;

namespace Mint.Blog.Model.Vos.Blog.Comment;

public sealed record SurferCommentListData(int Total, IReadOnlyCollection<SurferCommentItem> Comments);
public sealed record SurferCommentItem(string Id, string Avatar, string Nickname, string Website, string Content, string CreateTime, string? ReplyNickname, IReadOnlyCollection<SurferCommentItem> ChildComments, bool IsShowReplyForm);
public sealed record SurferCommentResponse<T>(bool Success, T? Data, string? Message = null, string? ErrorCode = null) {
    public static SurferCommentResponse<T> Ok(T? data, string? message = null) => new(true, data, message);
    public static SurferCommentResponse<T> Fail(string message, string? errorCode = null) => new(false, default, message, errorCode);
}

public sealed record PublishCommentResult(bool IsSuccess, string? ErrorCode = null, string? Message = null);
public sealed record CommentListDto(int Total, IReadOnlyCollection<CommentItemDto>? Comments);
public sealed record CommentItemDto(long Id, string Avatar, string Nickname, string Website, string Content, DateTimeOffset CreatedAt, string? ReplyNickname, IReadOnlyCollection<CommentItemDto> ChildComments, bool IsShowReplyForm);
public sealed record AdminCommentPageItemDto(long Id, string RouterUrl, string Avatar, string Nickname, string Mail, string Website, DateTimeOffset CreatedAt, string Content, int Status, string Reason, bool IsDeleted);
public sealed record QqUserInfoDto(string Avatar, string Nickname, string Mail);
public sealed class QqUserInfoResponse {
    [JsonPropertyName("code")] public int Code { get; set; }
    [JsonPropertyName("imgurl")] public string Avatar { get; set; } = string.Empty;
    [JsonPropertyName("name")] public string Nickname { get; set; } = string.Empty;
    [JsonPropertyName("mail")] public string Mail { get; set; } = string.Empty;
}
