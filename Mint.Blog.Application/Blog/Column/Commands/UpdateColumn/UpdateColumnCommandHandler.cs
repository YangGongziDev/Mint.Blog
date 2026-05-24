using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Column.Repositories;

namespace Mint.Blog.Application.Blog.Column.Commands.UpdateColumn;

public sealed class UpdateColumnCommandHandler(IColumnRepository columnRepository, IUnitOfWork unitOfWork) {
	public async Task HandleAsync(UpdateColumnCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Title), ErrorCodes.ColumnTitleInvalid, "Column title is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Summary), ErrorCodes.ColumnSummaryInvalid,
			"Column summary is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Cover), ErrorCodes.ColumnCoverInvalid, "Column cover is required.");

		var column = await columnRepository.GetByIdAsync(command.ColumnId, cancellationToken);
		Guard.Against(column is null, ErrorCodes.ColumnNotFound, "Column not found.");

		var title = command.Title.Trim();
		var exists = await columnRepository.ExistsByTitleAsync(title, command.ColumnId, cancellationToken);
		Guard.Against(exists, ErrorCodes.ColumnTitleDuplicate, "Column title already exists.");

		column!.Update(title, command.Summary.Trim(), command.Cover.Trim());

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