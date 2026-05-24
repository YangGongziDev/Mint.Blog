using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Friend.Repositories;

namespace Mint.Blog.Application.Blog.Friend.Commands.SetFriendStatus;

public sealed class SetFriendStatusCommandHandler(IFriendRepository friendRepository) {
	public async Task HandleAsync(SetFriendStatusCommand command, CancellationToken cancellationToken = default){
		var friend = await friendRepository.GetByIdAsync(command.FriendId, cancellationToken);
		Guard.Against(friend is null, ErrorCodes.FriendNotFound, "Friend does not exist.");

		try {
			friend!.SetStatus(command.Status);
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.FriendStatusInvalid, "Friend status is invalid.");
		}

		await friendRepository.UpdateAsync(friend, cancellationToken);
	}
}
