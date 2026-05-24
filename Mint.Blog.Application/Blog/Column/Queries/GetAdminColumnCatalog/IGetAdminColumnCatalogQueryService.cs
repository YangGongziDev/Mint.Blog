namespace Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnCatalog;

public interface IGetAdminColumnCatalogQueryService {
	Task<IReadOnlyCollection<AdminColumnCatalogItemDto>> GetAsync(long columnId,
		CancellationToken cancellationToken = default);
}