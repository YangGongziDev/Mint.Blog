using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Tag.Commands.CreateTag;

public sealed record CreateTagCommand(string Name);

public sealed class CreateTagCommandHandler(ITagRepository tagRepository) {
	public async Task<long> HandleAsync(CreateTagCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.TagNameInvalid, "Tag name is required.");
		return await tagRepository.AddAsync(command.Name.Trim(), cancellationToken);
	}
}