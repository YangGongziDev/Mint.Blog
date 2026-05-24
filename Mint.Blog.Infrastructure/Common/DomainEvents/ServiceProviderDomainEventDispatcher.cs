using Microsoft.Extensions.DependencyInjection;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Common;

namespace Mint.Blog.Infrastructure.Common.DomainEvents;

public sealed class ServiceProviderDomainEventDispatcher(IServiceProvider serviceProvider) : IDomainEventDispatcher {
	public Task DispatchAsync(IEnumerable<IDomainEvent> domainEvents, CancellationToken cancellationToken = default){
		return DispatchAllAsync(domainEvents, cancellationToken);
	}

	public Task DispatchAsync(IDomainEvent domainEvent, CancellationToken cancellationToken = default){
		return DispatchCoreAsync(domainEvent, cancellationToken);
	}

	private async Task DispatchAllAsync(IEnumerable<IDomainEvent> domainEvents, CancellationToken cancellationToken){
		foreach (var domainEvent in domainEvents)
			await DispatchCoreAsync(domainEvent, cancellationToken);
	}

	private async Task DispatchCoreAsync(IDomainEvent domainEvent, CancellationToken cancellationToken){
		var handlerType = typeof(IDomainEventHandler<>).MakeGenericType(domainEvent.GetType());
		var handlers = serviceProvider.GetServices(handlerType);
		var handleMethod = handlerType.GetMethod(nameof(IDomainEventHandler<IDomainEvent>.HandleAsync));

		foreach (var handler in handlers) {
			var task = (Task?)handleMethod?.Invoke(handler, [domainEvent, cancellationToken]);
			if (task is not null)
				await task;
		}
	}
}
