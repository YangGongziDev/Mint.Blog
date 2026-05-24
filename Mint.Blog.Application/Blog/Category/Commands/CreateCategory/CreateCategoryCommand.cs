using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Category.Repositories;

namespace Mint.Blog.Application.Blog.Category.Commands.CreateCategory;

public sealed record CreateCategoryCommand(string Name);

public sealed class CreateCategoryCommandHandler(ICategoryRepository categoryRepository) {
	public async Task<long> HandleAsync(CreateCategoryCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.CategoryNameInvalid,
			"Category name is required.");
		return await categoryRepository.AddAsync(command.Name.Trim(), cancellationToken);
	}
}