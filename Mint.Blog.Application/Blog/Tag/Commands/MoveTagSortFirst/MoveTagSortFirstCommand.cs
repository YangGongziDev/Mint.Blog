using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Tag.Commands.MoveTagSortFirst;

public sealed record MoveTagSortFirstCommand(long TagId);

public sealed class MoveTagSortFirstCommandHandler(ITagRepository tagRepository) {
	public async Task HandleAsync(MoveTagSortFirstCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await tagRepository.ExistsAsync(command.TagId, cancellationToken), ErrorCodes.TagNotFound,
			"Tag does not exist.");
		await tagRepository.MoveSortFirstAsync(command.TagId, cancellationToken);
	}
}
