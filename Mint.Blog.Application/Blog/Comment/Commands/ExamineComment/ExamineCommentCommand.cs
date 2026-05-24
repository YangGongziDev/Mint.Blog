namespace Mint.Blog.Application.Blog.Comment.Commands.ExamineComment;

public sealed record ExamineCommentCommand(long Id, int Status, string? Reason);