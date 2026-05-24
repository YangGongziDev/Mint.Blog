using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Category.Repositories;

namespace Mint.Blog.Application.Blog.Category.Commands.MoveCategorySortFirst;

public sealed record MoveCategorySortFirstCommand(long CategoryId);

public sealed class MoveCategorySortFirstCommandHandler(ICategoryRepository categoryRepository) {
	public async Task HandleAsync(MoveCategorySortFirstCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await categoryRepository.ExistsAsync(command.CategoryId, cancellationToken),
			ErrorCodes.CategoryNotFound, "Category does not exist.");
		await categoryRepository.MoveSortFirstAsync(command.CategoryId, cancellationToken);
	}
}
