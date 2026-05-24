using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Column.Repositories;

namespace Mint.Blog.Application.Blog.Column.Commands.UpdateColumnCatalog;

public sealed class UpdateColumnCatalogCommandHandler(IColumnRepository columnRepository, IUnitOfWork unitOfWork) {
	public async Task HandleAsync(UpdateColumnCatalogCommand command, CancellationToken cancellationToken = default){
		var column = await columnRepository.GetByIdAsync(command.ColumnId, cancellationToken);
		Guard.Against(column is null, ErrorCodes.ColumnNotFound, "Column not found.");

		var normalizedCatalogs = Normalize(command.Catalogs);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await columnRepository.UpdateCatalogAsync(command.ColumnId, normalizedCatalogs, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}

	private static IReadOnlyCollection<ColumnCatalogUpsertModel> Normalize(
		IReadOnlyCollection<UpdateColumnCatalogItemCommand> catalogs){
		var result = new List<ColumnCatalogUpsertModel>();

		for (var i = 0; i < catalogs.Count; i++) {
			var parent = catalogs.ElementAt(i);
			result.Add(new ColumnCatalogUpsertModel(parent.Title.Trim(), 0, 1, 0, i + 1));

			for (var j = 0; j < parent.Children.Count; j++) {
				var child = parent.Children.ElementAt(j);
				result.Add(new ColumnCatalogUpsertModel(child.Title.Trim(), child.ArticleId, 2, i + 1, j + 1));
			}
		}

		return result;
	}
}