using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.Events;

public sealed record ArticleVisibilityChangedDomainEvent(
	long ArticleId,
	ArticleVisibility Visibility,
	DateTimeOffset OccurredAt) : IDomainEvent;
