using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Column.Repositories;

namespace Mint.Blog.Application.Blog.Column.Commands.DeleteColumn;

public sealed class DeleteColumnCommandHandler(IColumnRepository columnRepository, IUnitOfWork unitOfWork) {
	public async Task HandleAsync(DeleteColumnCommand command, CancellationToken cancellationToken = default){
		var column = await columnRepository.GetByIdAsync(command.ColumnId, cancellationToken);
		Guard.Against(column is null, ErrorCodes.ColumnNotFound, "Column not found.");

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			switch (command.DeleteType) {
				case 1:
					column!.MarkDeleted();
					await columnRepository.UpdateAsync(column, cancellationToken);
					break;
				case 2:
					await columnRepository.DeleteAsync(command.ColumnId, cancellationToken);
					break;
				case 3:
					column!.Restore();
					await columnRepository.UpdateAsync(column, cancellationToken);
					break;
				default:
					throw new ArgumentOutOfRangeException(nameof(command.DeleteType), "Unsupported delete type.");
			}

			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}
}