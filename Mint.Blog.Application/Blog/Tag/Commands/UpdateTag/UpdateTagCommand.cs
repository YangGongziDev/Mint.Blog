using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Tag.Commands.UpdateTag;

public sealed record UpdateTagCommand(long TagId, string Name);

public sealed class UpdateTagCommandHandler(ITagRepository tagRepository) {
	public async Task HandleAsync(UpdateTagCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!await tagRepository.ExistsAsync(command.TagId, cancellationToken), ErrorCodes.TagNotFound,
			"Tag does not exist.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.TagNameInvalid, "Tag name is required.");
		await tagRepository.UpdateAsync(command.TagId, command.Name.Trim(), cancellationToken);
	}
}