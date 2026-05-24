using Mint.Blog.Domain.Common;

namespace Mint.Blog.Application.Abstractions;

public interface IDomainEventHandler<in TDomainEvent> where TDomainEvent : IDomainEvent {
	Task HandleAsync(TDomainEvent domainEvent, CancellationToken cancellationToken = default);
}
