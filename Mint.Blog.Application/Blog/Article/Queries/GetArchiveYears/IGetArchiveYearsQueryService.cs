namespace Mint.Blog.Application.Blog.Article.Queries.GetArchiveYears;

public sealed record ArchiveYearDto(int Year, int ArticlesTotal);

public interface IGetArchiveYearsQueryService {
	Task<IReadOnlyCollection<ArchiveYearDto>> GetAsync(CancellationToken cancellationToken = default);
}