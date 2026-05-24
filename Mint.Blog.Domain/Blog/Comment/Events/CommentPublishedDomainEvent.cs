using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Comment.Events;

public sealed record CommentPublishedDomainEvent(long CommentId, int Status, DateTimeOffset OccurredAt) : IDomainEvent;
