using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Comment.Queries.GetAdminCommentPageList;

public interface IGetAdminCommentPageListQueryService {
	Task<PagedResult<AdminCommentPageItemDto>> GetAsync(
		GetAdminCommentPageListQuery query, CancellationToken cancellationToken = default);
}