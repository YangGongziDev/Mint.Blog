namespace Mint.Blog.Application.Abstractions;

public interface IUnitOfWork {
	Task BeginTransactionAsync(CancellationToken cancellationToken = default);
	Task CommitAsync(CancellationToken cancellationToken = default);
	Task RollbackAsync(CancellationToken cancellationToken = default);
}