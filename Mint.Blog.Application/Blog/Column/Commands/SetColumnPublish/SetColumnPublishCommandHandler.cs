using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Column.Repositories;

namespace Mint.Blog.Application.Blog.Column.Commands.SetColumnPublish;

public sealed class SetColumnPublishCommandHandler(
	IColumnRepository columnRepository,
	IUnitOfWork unitOfWork,
	IDomainEventDispatcher domainEventDispatcher) {
	public async Task HandleAsync(SetColumnPublishCommand command, CancellationToken cancellationToken = default){
		var column = await columnRepository.GetByIdAsync(command.ColumnId, cancellationToken);
		Guard.Against(column is null, ErrorCodes.ColumnNotFound, "Column not found.");

		column!.SetPublish(command.IsPublish);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await columnRepository.UpdateAsync(column, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}

		if (column.DomainEvents.Count > 0) {
			await domainEventDispatcher.DispatchAsync(column.DomainEvents, cancellationToken);
			column.ClearDomainEvents();
		}
	}
}