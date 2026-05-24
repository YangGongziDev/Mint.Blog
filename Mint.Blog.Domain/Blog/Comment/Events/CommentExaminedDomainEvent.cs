using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Comment.Events;

public sealed record CommentExaminedDomainEvent(long CommentId, int Status, DateTimeOffset OccurredAt) : IDomainEvent;
