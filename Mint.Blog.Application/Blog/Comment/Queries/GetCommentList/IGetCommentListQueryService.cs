namespace Mint.Blog.Application.Blog.Comment.Queries.GetCommentList;

public interface IGetCommentListQueryService {
	Task<CommentListDto> GetAsync(GetCommentListQuery query, CancellationToken cancellationToken = default);
}