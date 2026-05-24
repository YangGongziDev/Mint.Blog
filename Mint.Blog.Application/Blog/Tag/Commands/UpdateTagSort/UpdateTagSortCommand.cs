using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Tag.Commands.UpdateTagSort;

public sealed record UpdateTagSortCommand(long TagId, int Sort);

public sealed class UpdateTagSortCommandHandler(ITagRepository tagRepository) {
	public async Task HandleAsync(UpdateTagSortCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await tagRepository.ExistsAsync(command.TagId, cancellationToken), ErrorCodes.TagNotFound,
			"Tag does not exist.");
		await tagRepository.UpdateSortAsync(command.TagId, command.Sort, cancellationToken);
	}
}
