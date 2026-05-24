using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Column.Events;

public sealed record ColumnPublishedDomainEvent(long ColumnId, DateTimeOffset OccurredAt) : IDomainEvent;
