using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.Events;

public sealed record ArticleTopChangedDomainEvent(long ArticleId, bool IsTop, DateTimeOffset OccurredAt) : IDomainEvent;
