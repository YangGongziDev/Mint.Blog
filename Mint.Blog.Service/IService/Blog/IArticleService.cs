using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Article;

namespace Mint.Blog.Service.IService.Blog;

public interface IArticleService {
    Task<PagedResult<ArticleListItemDto>> GetAsync(ArticleListQuery query, CancellationToken cancellationToken = default);
    Task<ArticleDetailDto?> GetAsync(ArticleDetailQuery query, CancellationToken cancellationToken = default);
    Task<PagedResult<SearchArticleItemDto>> GetAsync(SearchArticlesQuery query, CancellationToken cancellationToken = default);
    Task<long> CreateAsync(CreateArticleCommand command, CancellationToken cancellationToken = default);
    Task UpdateAsync(UpdateArticleCommand command, CancellationToken cancellationToken = default);
    Task PatchAsync(PatchArticleCommand command, CancellationToken cancellationToken = default);
    Task DeleteAsync(DeleteArticleCommand command, CancellationToken cancellationToken = default);
}
public interface IArticleReadQueue {
    ValueTask EnqueueAsync(long articleId, CancellationToken cancellationToken = default);
}
public interface IArticleImageStorage {
    Task DeleteManyAsync(IReadOnlyCollection<string> images, CancellationToken cancellationToken = default);
}
