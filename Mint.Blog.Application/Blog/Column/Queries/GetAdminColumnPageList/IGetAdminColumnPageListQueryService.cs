using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnPageList;

public interface IGetAdminColumnPageListQueryService {
	Task<PagedResult<AdminColumnPageItemDto>> GetAsync(GetAdminColumnPageListQuery query,
		CancellationToken cancellationToken = default);
}