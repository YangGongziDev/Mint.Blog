using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Friend.Queries.GetAdminFriendPageList;

public interface IGetAdminFriendPageListQueryService {
	Task<PagedResult<AdminFriendPageItemDto>> GetAsync(GetAdminFriendPageListQuery query,
		CancellationToken cancellationToken = default);
}