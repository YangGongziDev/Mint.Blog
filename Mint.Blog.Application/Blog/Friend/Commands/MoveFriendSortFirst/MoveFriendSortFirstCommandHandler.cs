using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Friend.Repositories;

namespace Mint.Blog.Application.Blog.Friend.Commands.MoveFriendSortFirst;

public sealed class MoveFriendSortFirstCommandHandler(IFriendRepository friendRepository) {
	public async Task HandleAsync(MoveFriendSortFirstCommand command, CancellationToken cancellationToken = default){
		var friend = await friendRepository.GetByIdAsync(command.FriendId, cancellationToken);
		Guard.Against(friend is null, ErrorCodes.FriendNotFound, "Friend does not exist.");

		var maxSort = await friendRepository.GetMaxSortAsync(cancellationToken);
		friend!.MoveSortFirst(maxSort);
		await friendRepository.UpdateAsync(friend, cancellationToken);
	}
}
