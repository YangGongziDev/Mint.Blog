using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Category.Repositories;

namespace Mint.Blog.Application.Blog.Category.Commands.DeleteCategory;

public sealed record DeleteCategoryCommand(long CategoryId, int DeleteType = 1);

public sealed class DeleteCategoryCommandHandler(ICategoryRepository categoryRepository) {
	public async Task HandleAsync(DeleteCategoryCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await categoryRepository.ExistsAsync(command.CategoryId, true, cancellationToken),
			ErrorCodes.CategoryNotFound, "Category does not exist.");
		await categoryRepository.DeleteAsync(command.CategoryId, command.DeleteType, cancellationToken);
	}
}