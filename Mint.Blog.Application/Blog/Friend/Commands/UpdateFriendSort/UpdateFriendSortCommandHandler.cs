using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Friend.Repositories;

namespace Mint.Blog.Application.Blog.Friend.Commands.UpdateFriendSort;

public sealed class UpdateFriendSortCommandHandler(IFriendRepository friendRepository) {
	public async Task HandleAsync(UpdateFriendSortCommand command, CancellationToken cancellationToken = default){
		var friend = await friendRepository.GetByIdAsync(command.FriendId, cancellationToken);
		Guard.Against(friend is null, ErrorCodes.FriendNotFound, "Friend does not exist.");

		friend!.UpdateSort(command.Sort);
		await friendRepository.UpdateAsync(friend, cancellationToken);
	}
}
