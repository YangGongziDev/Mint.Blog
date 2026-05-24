namespace Mint.Blog.Domain.Common;

public abstract class Entity<TId> {
	public virtual TId Id { get; protected set; } = default!;
}