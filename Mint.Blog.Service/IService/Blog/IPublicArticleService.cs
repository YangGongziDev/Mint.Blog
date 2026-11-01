using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;

namespace Mint.Blog.Service.IService.Blog;

public interface IPublicArticleService {
    Task<BlogHomeDto> GetHomeAsync(BlogHomeQuery query, CancellationToken ct = default);
    Task<PagedResult<ArchiveMonthGroupDto>> GetArchivePageAsync(GetArchivePageListQuery query, CancellationToken ct = default);
    Task<IReadOnlyCollection<ArchiveMonthGroupDto>> GetArchiveYearAsync(GetArchiveYearListQuery query, CancellationToken ct = default);
    Task<IReadOnlyCollection<ArchiveYearDto>> GetArchiveYearsAsync(CancellationToken ct = default);
    Task<SurferArchivePageResponse> GetArchiveAsync(SurferArchivePageRequest? request, CancellationToken ct = default);
    Task<IReadOnlyCollection<RssArticleDto>> GetRssAsync(CancellationToken ct = default);
}
