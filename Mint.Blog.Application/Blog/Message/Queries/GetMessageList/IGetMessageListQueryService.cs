using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Message.Queries.GetMessageList;

public interface IGetMessageListQueryService {
	Task<PagedResult<MessageListItemDto>> GetAsync(GetMessageListQuery query,
		CancellationToken cancellationToken = default);
}
