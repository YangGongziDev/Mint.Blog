using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Friend.Repositories;

namespace Mint.Blog.Application.Blog.Friend.Commands.DeleteFriend;

public sealed class DeleteFriendCommandHandler(IFriendRepository friendRepository) {
	public async Task HandleAsync(DeleteFriendCommand command, CancellationToken cancellationToken = default){
		Guard.Against(command.DeleteType is not 1 and not 2 and not 3, ErrorCodes.DeleteTypeInvalid,
			"Delete type is invalid.");

		var friend = await friendRepository.GetByIdIncludingDeletedAsync(command.FriendId, cancellationToken);
		Guard.Against(friend is null, ErrorCodes.FriendNotFound, "Friend does not exist.");

		if (command.DeleteType == 2) {
			await friendRepository.DeleteAsync(command.FriendId, cancellationToken);
			return;
		}

		if (command.DeleteType == 1)
			friend!.MarkDeleted();
		else
			friend!.Restore();

		await friendRepository.UpdateAsync(friend, cancellationToken);
	}
}
