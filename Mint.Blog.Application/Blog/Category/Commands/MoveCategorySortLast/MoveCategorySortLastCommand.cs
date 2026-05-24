using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Category.Repositories;

namespace Mint.Blog.Application.Blog.Category.Commands.MoveCategorySortLast;

public sealed record MoveCategorySortLastCommand(long CategoryId);

public sealed class MoveCategorySortLastCommandHandler(ICategoryRepository categoryRepository) {
	public async Task HandleAsync(MoveCategorySortLastCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await categoryRepository.ExistsAsync(command.CategoryId, cancellationToken),
			ErrorCodes.CategoryNotFound, "Category does not exist.");
		await categoryRepository.MoveSortLastAsync(command.CategoryId, cancellationToken);
	}
}
