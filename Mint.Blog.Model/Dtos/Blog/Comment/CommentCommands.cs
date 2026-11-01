using System.Text.Json;

namespace Mint.Blog.Model.Dtos.Blog.Comment;

public sealed record SurferPublishCommentRequest(string? Avatar, string? Nickname, string? Mail, string? Website, string? RouterUrl, string? Content, JsonElement? ReplyCommentId, JsonElement? ParentCommentId);
public sealed record SurferCommentListRequest(string RouterUrl);
public sealed record SurferQqUserInfoRequest(string Qq);

public sealed record PublishCommentCommand(string Avatar, string Nickname, string Mail, string Website, string RouterUrl, string Content, long? ReplyCommentId, long? ParentCommentId);
public sealed record DeleteCommentCommand(long Id, long DeleteType);
public sealed record ExamineCommentCommand(long Id, int Status, string? Reason);
public sealed record GetCommentListQuery(string RouterUrl);
public sealed record GetQqUserInfoQuery(string Qq);
public sealed record GetAdminCommentPageListQuery(int PageNumber, int PageSize, string? RouterUrl, DateOnly? StartDate, DateOnly? EndDate, int? Status, string? SortOrder = null);
public sealed record CommentNotificationJob(CommentNotificationKind Kind, long CommentId);
public enum CommentNotificationKind { Published = 1, Examined = 2 }
