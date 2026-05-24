using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Friend.Repositories;

namespace Mint.Blog.Application.Blog.Friend.Commands.SetFriendTop;

public sealed class SetFriendTopCommandHandler(IFriendRepository friendRepository) {
	public async Task HandleAsync(SetFriendTopCommand command, CancellationToken cancellationToken = default){
		var friend = await friendRepository.GetByIdAsync(command.FriendId, cancellationToken);
		Guard.Against(friend is null, ErrorCodes.FriendNotFound, "Friend does not exist.");

		friend!.SetTop(command.IsTop);
		await friendRepository.UpdateAsync(friend, cancellationToken);
	}
}
