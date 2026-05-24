namespace Mint.Blog.Application.Blog.Comment.Commands.DeleteComment;

public sealed record DeleteCommentCommand(long Id, long DeleteType);