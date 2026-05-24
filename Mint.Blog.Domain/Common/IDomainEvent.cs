namespace Mint.Blog.Domain.Common;

public interface IDomainEvent {
	DateTimeOffset OccurredAt { get; }
}
