using ColumnEntity = Mint.Blog.Domain.Blog.Column.Entities.Column;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Column.Repositories;

namespace Mint.Blog.Application.Blog.Column.Commands.CreateColumn;

public sealed class CreateColumnCommandHandler(IColumnRepository columnRepository, IUnitOfWork unitOfWork) {
	public async Task<long> HandleAsync(CreateColumnCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Title), ErrorCodes.ColumnTitleInvalid, "Column title is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Summary), ErrorCodes.ColumnSummaryInvalid,
			"Column summary is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Cover), ErrorCodes.ColumnCoverInvalid, "Column cover is required.");

		var title = command.Title.Trim();
		var exists = await columnRepository.ExistsByTitleAsync(title, null, cancellationToken);
		Guard.Against(exists, ErrorCodes.ColumnTitleDuplicate, "Column title already exists.");

		var column = ColumnEntity.Create(title, command.Summary.Trim(), command.Cover.Trim());

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			var id = await columnRepository.AddAsync(column, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
			return id;
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}
}