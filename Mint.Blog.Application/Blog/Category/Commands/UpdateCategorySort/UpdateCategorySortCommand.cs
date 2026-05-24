using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Category.Repositories;

namespace Mint.Blog.Application.Blog.Category.Commands.UpdateCategorySort;

public sealed record UpdateCategorySortCommand(long CategoryId, int Sort);

public sealed class UpdateCategorySortCommandHandler(ICategoryRepository categoryRepository) {
	public async Task HandleAsync(UpdateCategorySortCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await categoryRepository.ExistsAsync(command.CategoryId, cancellationToken),
			ErrorCodes.CategoryNotFound, "Category does not exist.");
		await categoryRepository.UpdateSortAsync(command.CategoryId, command.Sort, cancellationToken);
	}
}
