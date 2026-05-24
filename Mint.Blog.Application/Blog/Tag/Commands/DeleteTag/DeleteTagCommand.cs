using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Tag.Commands.DeleteTag;

public sealed record DeleteTagCommand(long TagId, int DeleteType = 1);

public sealed class DeleteTagCommandHandler(ITagRepository tagRepository) {
	public async Task HandleAsync(DeleteTagCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await tagRepository.ExistsAsync(command.TagId, true, cancellationToken), ErrorCodes.TagNotFound,
			"Tag does not exist.");
		await tagRepository.DeleteAsync(command.TagId, command.DeleteType, cancellationToken);
	}
}