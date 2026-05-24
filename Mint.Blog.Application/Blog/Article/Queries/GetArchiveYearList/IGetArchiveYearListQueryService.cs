using Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;

namespace Mint.Blog.Application.Blog.Article.Queries.GetArchiveYearList;

public interface IGetArchiveYearListQueryService {
	Task<IReadOnlyCollection<ArchiveMonthGroupDto>> GetAsync(GetArchiveYearListQuery query,
		CancellationToken cancellationToken = default);
}