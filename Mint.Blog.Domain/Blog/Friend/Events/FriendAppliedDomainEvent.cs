using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Friend.Events;

public sealed record FriendAppliedDomainEvent(long FriendId, DateTimeOffset OccurredAt) : IDomainEvent;
