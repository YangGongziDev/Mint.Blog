using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.Events;

public sealed record ArticleCreatedDomainEvent(long ArticleId, DateTimeOffset OccurredAt) : IDomainEvent;
