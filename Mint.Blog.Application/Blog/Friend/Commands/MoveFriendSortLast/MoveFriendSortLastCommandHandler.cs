using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Friend.Repositories;

namespace Mint.Blog.Application.Blog.Friend.Commands.MoveFriendSortLast;

public sealed class MoveFriendSortLastCommandHandler(IFriendRepository friendRepository) {
	public async Task HandleAsync(MoveFriendSortLastCommand command, CancellationToken cancellationToken = default){
		var friend = await friendRepository.GetByIdAsync(command.FriendId, cancellationToken);
		Guard.Against(friend is null, ErrorCodes.FriendNotFound, "Friend does not exist.");

		var minSort = await friendRepository.GetMinSortAsync(cancellationToken);
		friend!.MoveSortLast(minSort);
		await friendRepository.UpdateAsync(friend, cancellationToken);
	}
}
