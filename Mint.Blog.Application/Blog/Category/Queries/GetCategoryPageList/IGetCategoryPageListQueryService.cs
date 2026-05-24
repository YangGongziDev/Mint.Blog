using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;

namespace Mint.Blog.Application.Blog.Category.Queries.GetCategoryPageList;

public interface IGetCategoryPageListQueryService {
	Task<PagedResult<CategoryListItemDto>> GetAsync(CategoryPageListQuery query,
		CancellationToken cancellationToken = default);
}
