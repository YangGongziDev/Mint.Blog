using ArticleEntity = Mint.Blog.Domain.Blog.Article.Entities.Article;
namespace Mint.Blog.Domain.Blog.Article.Repositories;

public interface IArticleRepository {
	Task<ArticleEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default);

	Task<IReadOnlyCollection<ArticleEntity>> GetPagedListAsync(int pageNumber, int pageSize,
		CancellationToken cancellationToken = default);

	Task<long> AddAsync(ArticleEntity article, CancellationToken cancellationToken = default);
	Task UpdateAsync(ArticleEntity article, CancellationToken cancellationToken = default);
	Task DeleteAsync(long id, long deleteType, CancellationToken cancellationToken = default);
}
