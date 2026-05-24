namespace Mint.Blog.Application.Blog.Comment.Commands.PublishComment;

public sealed record PublishCommentCommand(
	string Avatar,
	string Nickname,
	string Mail,
	string Website,
	string RouterUrl,
	string Content,
	long? ReplyCommentId,
	long? ParentCommentId);