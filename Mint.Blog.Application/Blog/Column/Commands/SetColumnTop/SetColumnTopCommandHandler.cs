using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Column.Repositories;

namespace Mint.Blog.Application.Blog.Column.Commands.SetColumnTop;

public sealed class SetColumnTopCommandHandler(IColumnRepository columnRepository, IUnitOfWork unitOfWork) {
	public async Task HandleAsync(SetColumnTopCommand command, CancellationToken cancellationToken = default){
		var column = await columnRepository.GetByIdAsync(command.ColumnId, cancellationToken);
		Guard.Against(column is null, ErrorCodes.ColumnNotFound, "Column not found.");

		var maxWeight = await columnRepository.GetMaxWeightAsync(cancellationToken);
		column!.SetTop(command.IsTop, maxWeight);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await columnRepository.UpdateAsync(column, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}
}