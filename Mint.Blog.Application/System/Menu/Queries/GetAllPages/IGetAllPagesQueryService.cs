namespace Mint.Blog.Application.System.Menu.Queries.GetAllPages;

public interface IGetAllPagesQueryService
{
    Task<IReadOnlyCollection<string>> GetAsync(CancellationToken cancellationToken = default);
}
