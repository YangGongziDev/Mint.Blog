using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Tag.Commands.MoveTagSortLast;

public sealed record MoveTagSortLastCommand(long TagId);

public sealed class MoveTagSortLastCommandHandler(ITagRepository tagRepository) {
	public async Task HandleAsync(MoveTagSortLastCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await tagRepository.ExistsAsync(command.TagId, cancellationToken), ErrorCodes.TagNotFound,
			"Tag does not exist.");
		await tagRepository.MoveSortLastAsync(command.TagId, cancellationToken);
	}
}
