using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Upload.Images;

public interface IManagedImageQueryService {
	Task<PagedResult<ManagedImageListItemDto>> GetAsync(ManagedImageListQuery query,
		CancellationToken cancellationToken = default);
}
