using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Entitys.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class PublicArticleService(IArticleRepository repository) : IPublicArticleService {
    public async Task<BlogHomeDto> GetHomeAsync(BlogHomeQuery query, CancellationToken ct = default) {
        var latest = await repository.GetHomeArticlesAsync(query.LatestArticleCount <= 0 ? 8 : query.LatestArticleCount, "latest", ct);
        var hot = await repository.GetHomeArticlesAsync(query.HotArticleCount <= 0 ? 8 : query.HotArticleCount, "hot", ct);
        var top = await repository.GetHomeArticlesAsync(query.TopArticleCount <= 0 ? 5 : query.TopArticleCount, "top", ct);
        var selections = await repository.GetSelectionsAsync(latest.Concat(hot).Concat(top).Select(x => x.Id).Distinct().ToArray(), ct);
        BlogHomeArticleDto Map(ArticleDataModel a) {
            var s = selections.GetValueOrDefault(a.Id) ?? new ArticleSelection();
            return new(a.Id, a.Title, a.Summary, a.Cover, s.CategoryId, s.CategoryName,
                a.TagId, a.TagVersionId, s.TagName, s.TagVersionName, s.IsGeneral, a.Weight > 0, a.ReadCount, a.CreatedAt);
        }
        return new(latest.Select(Map).ToArray(), hot.Select(Map).ToArray(), top.Select(Map).ToArray());
    }
    public async Task<PagedResult<ArchiveMonthGroupDto>> GetArchivePageAsync(GetArchivePageListQuery query, CancellationToken ct = default) {
        ct.ThrowIfCancellationRequested();
        var page = await repository.GetArchivePageAsync(Math.Max(1, query.PageNumber), Math.Clamp(query.PageSize, 1, 100), ct);
        return new(await BuildArchiveGroups(page.Items, ct), page.PageNumber, page.PageSize, page.TotalCount);
    }
    public async Task<IReadOnlyCollection<ArchiveMonthGroupDto>> GetArchiveYearAsync(GetArchiveYearListQuery query, CancellationToken ct = default) {
        ct.ThrowIfCancellationRequested();
        var start = new DateTimeOffset(new DateTime(query.Year, 1, 1, 0, 0, 0, DateTimeKind.Utc));
        return await BuildArchiveGroups(await repository.GetArchiveArticlesAsync(start, start.AddYears(1), ct), ct);
    }
    public async Task<IReadOnlyCollection<ArchiveYearDto>> GetArchiveYearsAsync(CancellationToken ct = default) {
        var articles = await repository.GetArchiveArticlesAsync(null, null, ct);
        return articles.GroupBy(x => x.CreatedAt.Year).Select(g => new ArchiveYearDto(g.Key, g.Count())).OrderByDescending(x => x.Year).ToArray();
    }
    public async Task<SurferArchivePageResponse> GetArchiveAsync(SurferArchivePageRequest? request, CancellationToken ct = default) {
        var current = request?.Current <= 0 ? 1 : request?.Current ?? 1;
        var size = request?.Size <= 0 ? 20 : request?.Size ?? 20;
        if (int.TryParse(request?.Year, out var year) && year > 0) {
            var groups = (await GetArchiveYearAsync(new(year), ct)).Select(ToSurferArchiveMonth).ToArray();
            return new(true, groups, 1, size, groups.Sum(x => x.Articles.Count), 1);
        }
        var result = await GetArchivePageAsync(new(current, size), ct);
        return new(true, result.Items.Select(ToSurferArchiveMonth).ToArray(), result.PageNumber, result.PageSize,
            result.TotalCount, (int)Math.Ceiling(result.TotalCount / (double)result.PageSize));
    }
    public Task<IReadOnlyCollection<RssArticleDto>> GetRssAsync(CancellationToken ct = default) => repository.GetRssAsync(ct);
    private async Task<IReadOnlyCollection<ArchiveMonthGroupDto>> BuildArchiveGroups(IReadOnlyCollection<ArticleDataModel> articles, CancellationToken ct) {
        var selections = await repository.GetSelectionsAsync(articles.Select(a => a.Id).ToArray(), ct);
        return articles.GroupBy(a => new DateOnly(a.CreatedAt.Year, a.CreatedAt.Month, 1)).OrderByDescending(g => g.Key)
            .Select(g => new ArchiveMonthGroupDto(g.Key.ToString("yyyy-MM"), g.OrderByDescending(a => a.CreatedAt)
                .Select(a => {
                    var s = selections.GetValueOrDefault(a.Id) ?? new ArticleSelection();
                    return new ArchiveArticleDto(a.Id, a.Cover, a.Title, DateOnly.FromDateTime(a.CreatedAt.UtcDateTime.Date),
                        a.TagId, a.TagVersionId, s.CategoryId, s.CategoryName, s.TagName, s.TagVersionName, s.IsGeneral);
                }).ToArray())).ToArray();
    }
    private static SurferArchiveMonth ToSurferArchiveMonth(ArchiveMonthGroupDto group) => new(group.Month,
        group.Articles.Select(a => new SurferArchiveArticle(a.Id, a.Title, a.Cover, a.CreatedDate.ToString("yyyy-MM-dd"),
            a.TagId, a.TagVersionId, a.CategoryId, a.CategoryName, a.TagName, a.TagVersionName, a.IsGeneral)).ToArray());
}
