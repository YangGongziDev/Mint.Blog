using CommentEntity = Mint.Blog.Domain.Blog.Comment.Entities.Comment;
namespace Mint.Blog.Domain.Blog.Comment.Repositories;

public interface ICommentRepository {
	Task<long> AddAsync(CommentEntity comment, CancellationToken cancellationToken = default);
	Task<CommentEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default);
	Task<CommentEntity?> GetByIdIncludingDeletedAsync(long id, CancellationToken cancellationToken = default);

	Task<IReadOnlyCollection<CommentEntity>> GetByRouterUrlAndStatusAsync(string routerUrl, int status,
		CancellationToken cancellationToken = default);

	Task<IReadOnlyCollection<CommentEntity>> GetAllAsync(CancellationToken cancellationToken = default);
	Task UpdateAsync(CommentEntity comment, CancellationToken cancellationToken = default);
	Task DeleteAsync(long id, CancellationToken cancellationToken = default);
}
