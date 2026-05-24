using Mint.Blog.Domain.Common;

namespace Mint.Blog.Application.Abstractions;

public interface IDomainEventDispatcher {
	Task DispatchAsync(IDomainEvent domainEvent, CancellationToken cancellationToken = default);
	Task DispatchAsync(IEnumerable<IDomainEvent> domainEvents, CancellationToken cancellationToken = default);
}
