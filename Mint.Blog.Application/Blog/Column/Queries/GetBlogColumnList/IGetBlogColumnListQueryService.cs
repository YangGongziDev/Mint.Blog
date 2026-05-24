namespace Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnList;

public interface IGetBlogColumnListQueryService {
	Task<IReadOnlyCollection<BlogColumnListItemDto>> GetAsync(CancellationToken cancellationToken = default);
}