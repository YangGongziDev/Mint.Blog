namespace Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnCatalog;

public interface IGetBlogColumnCatalogQueryService {
	Task<IReadOnlyCollection<BlogColumnCatalogItemDto>> GetAsync(BlogColumnCatalogQuery query,
		CancellationToken cancellationToken = default);
}