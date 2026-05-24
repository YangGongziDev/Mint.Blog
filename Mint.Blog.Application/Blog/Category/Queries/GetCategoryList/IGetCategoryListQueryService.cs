namespace Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;

public interface IGetCategoryListQueryService {
	Task<IReadOnlyCollection<CategoryListItemDto>> GetAsync(CancellationToken cancellationToken = default);
}