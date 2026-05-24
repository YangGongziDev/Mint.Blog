using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Friend.Events;

namespace Mint.Blog.Application.Blog.Friend.EventHandlers;

public sealed class FriendAppliedDomainEventHandler : IDomainEventHandler<FriendAppliedDomainEvent> {
	public Task HandleAsync(FriendAppliedDomainEvent domainEvent, CancellationToken cancellationToken = default){
		return Task.CompletedTask;
	}
}
