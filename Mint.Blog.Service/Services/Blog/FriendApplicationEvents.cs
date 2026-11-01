using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class FriendApplicationEvents : IFriendApplicationEvents {
	// The former FriendAppliedDomainEventHandler intentionally performed no work.
	public Task AppliedAsync(long friendId, DateTimeOffset occurredAt, CancellationToken cancellationToken = default) =>
		Task.CompletedTask;
}
