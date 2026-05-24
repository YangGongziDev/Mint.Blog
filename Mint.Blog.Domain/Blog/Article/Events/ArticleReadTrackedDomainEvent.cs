using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.Events;

public sealed record ArticleReadTrackedDomainEvent(long ArticleId, long ReadCount, DateTimeOffset OccurredAt) : IDomainEvent;
