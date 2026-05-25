using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Column.Repositories;

namespace Mint.Blog.Application.Blog.Column.Commands.UpdateColumnCatalog;

public sealed class UpdateColumnCatalogCommandHandler(IColumnRepository columnRepository, IUnitOfWork unitOfWork) {
	public async Task HandleAsync(UpdateColumnCatalogCommand command, CancellationToken cancellationToken = default){
		var column = await columnRepository.GetByIdAsync(command.ColumnId, cancellationToken);
		Guard.Against(column is null, ErrorCodes.ColumnNotFound, "Column not found.");

		var normalizedCatalogs = Normalize(command.Catalogs);

		var articleIds = normalizedCatalogs
			.Where(x => x.ArticleId.HasValue && x.ArticleId > 0)
			.Select(x => x.ArticleId!.Value)
			.ToArray();

		var duplicatedIds = articleIds.GroupBy(id => id).Where(g => g.Count() > 1).Select(g => g.Key).ToArray();
		Guard.Against(duplicatedIds.Length > 0, ErrorCodes.ColumnCatalogArticleDuplicate,
			$"以下文章 ID 在同一专栏中重复引用：{string.Join(", ", duplicatedIds)}");

		if (articleIds.Length > 0) {
			await columnRepository.ValidateArticleIdsAsync(articleIds.Distinct().ToArray(), cancellationToken);
		}

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
			result.Add(new ColumnCatalogUpsertModel(parent.Title.Trim(), null, 1, 0, i + 1, parent.IsDeleted));

			for (var j = 0; j < parent.Children.Count; j++) {
				var child = parent.Children.ElementAt(j);
				var articleId = child.ArticleId > 0 ? child.ArticleId : (long?)null;
				result.Add(new ColumnCatalogUpsertModel(child.Title.Trim(), articleId, 2, i + 1, j + 1, child.IsDeleted));
			}
		}

		return result;
	}
}