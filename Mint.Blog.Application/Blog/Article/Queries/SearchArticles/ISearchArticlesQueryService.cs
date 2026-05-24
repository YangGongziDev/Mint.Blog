using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Article.Queries.SearchArticles;

public interface ISearchArticlesQueryService {
	Task<PagedResult<SearchArticleItemDto>> GetAsync(SearchArticlesQuery query,
		CancellationToken cancellationToken = default);
}