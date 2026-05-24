namespace Mint.Blog.Application.Blog.Comment.Queries.GetCommentList;

public sealed record CommentListDto(int Total, IReadOnlyCollection<CommentItemDto>? Comments);