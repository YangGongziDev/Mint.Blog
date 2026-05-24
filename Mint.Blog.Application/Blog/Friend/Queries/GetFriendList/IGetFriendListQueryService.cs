using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Friend.Queries.GetFriendList;

public interface IGetFriendListQueryService {
	Task<PagedResult<FriendListItemDto>> GetAsync(GetFriendListQuery query,
		CancellationToken cancellationToken = default);
}