using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Domain.System.User.ValueObjects;

namespace Mint.Blog.Infrastructure.System.Auth;

public sealed class ConfiguredAdminCredentialValidator(
	IUserRepository userRepository,
	IPasswordHasher passwordHasher) : IAdminCredentialValidator {
	public AdminCredentialValidationResult? Validate(string userName, string password){
		var normalizedUserName = UserName.Create(userName);
		var user = userRepository.GetByUserNameAsync(normalizedUserName).GetAwaiter().GetResult();
		if (user is null || !passwordHasher.Verify(password, user.PasswordHash)) return null;
		var roles = userRepository.GetRolesAsync(normalizedUserName.Value).GetAwaiter().GetResult();
		return new AdminCredentialValidationResult(user.Id, user.UserName.Value, user.DisplayName, roles);
	}
}
