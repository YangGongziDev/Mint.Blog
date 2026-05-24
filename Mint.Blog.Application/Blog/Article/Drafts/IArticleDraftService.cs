using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Article.Drafts;

public interface IArticleDraftService {
	Task<PagedResult<ArticleDraftListItemDto>> GetListAsync(int pageNumber, int pageSize,
		CancellationToken cancellationToken = default);

	Task<ArticleDraftDto?> GetByIdAsync(long draftId, CancellationToken cancellationToken = default);
	Task<ArticleDraftDto?> GetByArticleIdAsync(long articleId, CancellationToken cancellationToken = default);
	Task<long> SaveAsync(SaveArticleDraftCommand command, CancellationToken cancellationToken = default);
	Task<long> PublishAsync(long draftId, CancellationToken cancellationToken = default);
	Task DeleteAsync(long draftId, CancellationToken cancellationToken = default);
}
