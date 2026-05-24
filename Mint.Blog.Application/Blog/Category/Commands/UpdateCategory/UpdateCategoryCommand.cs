using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Category.Repositories;

namespace Mint.Blog.Application.Blog.Category.Commands.UpdateCategory;

public sealed record UpdateCategoryCommand(long CategoryId, string Name);

public sealed class UpdateCategoryCommandHandler(ICategoryRepository categoryRepository) {
	public async Task HandleAsync(UpdateCategoryCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await categoryRepository.ExistsAsync(command.CategoryId, cancellationToken),
			ErrorCodes.CategoryNotFound, "Category does not exist.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.CategoryNameInvalid,
			"Category name is required.");
		await categoryRepository.UpdateAsync(command.CategoryId, command.Name.Trim(), cancellationToken);
	}
}