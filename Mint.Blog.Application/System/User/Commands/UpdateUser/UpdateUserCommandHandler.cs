using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Repositories;

namespace Mint.Blog.Application.System.User.Commands.UpdateUser;

public sealed class UpdateUserCommandHandler(IUserRepository userRepository)
{
    public async Task HandleAsync(UpdateUserCommand command, CancellationToken cancellationToken = default)
    {
        Guard.Against(command.UserId <= 0, ErrorCodes.UserNotFound, "User id is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.UserName), ErrorCodes.UserNotFound, "User name is required.");
        Guard.Against(command.IsDeleted is not 0 and not 1, ErrorCodes.UserNotFound, "Invalid is_deleted value.");

        var user = await userRepository.GetByIdIncludingDeletedAsync(command.UserId, cancellationToken);
        Guard.Against(user is null, ErrorCodes.UserNotFound, "User does not exist.");

        user!.UpdateProfile(command.UserName, command.DisplayName, command.IsDeleted == 1);
        await userRepository.UpdateAsync(user, cancellationToken);
    }
}
