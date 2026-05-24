namespace Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

public interface IGetArticleListQueryService {
	Task<PagedResult<ArticleListItemDto>> GetAsync(ArticleListQuery query,
		CancellationToken cancellationToken = default);
}