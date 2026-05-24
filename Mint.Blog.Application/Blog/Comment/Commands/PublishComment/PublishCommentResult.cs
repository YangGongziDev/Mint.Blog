namespace Mint.Blog.Application.Blog.Comment.Commands.PublishComment;

public sealed record PublishCommentResult(bool IsSuccess, string? ErrorCode = null, string? Message = null);