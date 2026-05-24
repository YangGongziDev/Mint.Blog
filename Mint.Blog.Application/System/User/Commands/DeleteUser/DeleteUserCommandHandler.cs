using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Repositories;

namespace Mint.Blog.Application.System.User.Commands.DeleteUser;

public sealed class DeleteUserCommandHandler(IUserRepository userRepository) {
	private const long LogicalDelete = 1;
	private const long PhysicalDelete = 2;
	private const long RestoreDelete = 3;

	public async Task HandleAsync(DeleteUserCommand command, CancellationToken cancellationToken = default){
		if (command.DeleteType == PhysicalDelete) {
			var exists = await userRepository.ExistsAsync(command.UserId, cancellationToken);
			Guard.Against(!exists, ErrorCodes.UserNotFound, "User does not exist.");
			await userRepository.DeleteAsync(command.UserId, cancellationToken);
			return;
		}

		var user = await userRepository.GetByIdIncludingDeletedAsync(command.UserId, cancellationToken);
		Guard.Against(user is null, ErrorCodes.UserNotFound, "User does not exist.");

		if (command.DeleteType == LogicalDelete) user!.MarkDeleted();
		else if (command.DeleteType == RestoreDelete) user!.Restore();
		else throw new BusinessException(ErrorCodes.UserNotFound, "Invalid delete type.");

		await userRepository.UpdateAsync(user, cancellationToken);
	}
}