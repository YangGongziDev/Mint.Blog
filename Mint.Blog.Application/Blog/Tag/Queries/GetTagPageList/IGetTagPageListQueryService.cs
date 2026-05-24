using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagList;

namespace Mint.Blog.Application.Blog.Tag.Queries.GetTagPageList;

public interface IGetTagPageListQueryService {
	Task<PagedResult<TagListItemDto>> GetAsync(TagPageListQuery query,
		CancellationToken cancellationToken = default);
}
