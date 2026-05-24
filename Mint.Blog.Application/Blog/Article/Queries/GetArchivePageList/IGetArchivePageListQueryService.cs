using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;

public interface IGetArchivePageListQueryService {
	Task<PagedResult<ArchiveMonthGroupDto>> GetAsync(GetArchivePageListQuery query,
		CancellationToken cancellationToken = default);
}