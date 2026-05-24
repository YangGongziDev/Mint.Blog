using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Domain.System.User.ValueObjects;

namespace Mint.Blog.Application.System.User.Commands.UpdateSystemUserPassword;

public sealed class UpdateSystemUserPasswordCommandHandler(
	IUserRepository userRepository,
	IPasswordHasher passwordHasher) {
	public async Task HandleAsync(UpdateSystemUserPasswordCommand command,
		CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.UserName), ErrorCodes.UserNotFound, "User name is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Password), ErrorCodes.UserPasswordInvalid,
			"Password is required.");

		var userName = UserName.Create(command.UserName);
		var user = await userRepository.GetByUserNameAsync(userName, cancellationToken);
		Guard.Against(user is null, ErrorCodes.UserNotFound, "User does not exist.");

		var passwordHash = passwordHasher.Hash(command.Password);
		user!.UpdatePassword(passwordHash);
		await userRepository.UpdateAsync(user, cancellationToken);
	}
}
