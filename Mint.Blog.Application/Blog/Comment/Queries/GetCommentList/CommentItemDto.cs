namespace Mint.Blog.Application.Blog.Comment.Queries.GetCommentList;

public sealed record CommentItemDto(
	long Id,
	string Avatar,
	string Nickname,
	string Website,
	string Content,
	DateTimeOffset CreatedAt,
	string? ReplyNickname,
	IReadOnlyCollection<CommentItemDto> ChildComments,
	bool IsShowReplyForm);