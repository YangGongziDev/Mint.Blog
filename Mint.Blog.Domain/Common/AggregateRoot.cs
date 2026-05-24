namespace Mint.Blog.Domain.Common;

public abstract class AggregateRoot<TId> : Entity<TId> {
	private readonly List<IDomainEvent> _domainEvents = [];

	public IReadOnlyCollection<IDomainEvent> DomainEvents => _domainEvents.AsReadOnly();

	protected void AddDomainEvent(IDomainEvent domainEvent){
		_domainEvents.Add(domainEvent);
	}

	public void ClearDomainEvents(){
		_domainEvents.Clear();
	}
}