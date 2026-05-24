namespace Mint.Blog.Application.Blog.Article.Queries.GetArchiveYears;

public interface IGetArchiveYearsQueryService {
	Task<IReadOnlyCollection<int>> GetAsync(CancellationToken cancellationToken = default);
}