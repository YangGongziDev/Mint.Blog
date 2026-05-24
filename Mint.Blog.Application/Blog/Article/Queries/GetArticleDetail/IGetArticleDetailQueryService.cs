namespace Mint.Blog.Application.Blog.Article.Queries.GetArticleDetail;

public interface IGetArticleDetailQueryService {
	Task<ArticleDetailDto?> GetAsync(ArticleDetailQuery query, CancellationToken cancellationToken = default);
}