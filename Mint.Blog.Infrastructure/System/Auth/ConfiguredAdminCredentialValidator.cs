using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Domain.System.User.ValueObjects;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;

namespace Mint.Blog.Infrastructure.System.Auth;

public sealed class ConfiguredAdminCredentialValidator(
	IUserRepository userRepository,
	IPasswordHasher passwordHasher,
	ISqlSugarDbContext dbContext) : IAdminCredentialValidator {
	public AdminCredentialValidationResult? Validate(string userName, string password){
		var normalizedUserName = UserName.Create(userName);
		var user = userRepository.GetByUserNameAsync(normalizedUserName).GetAwaiter().GetResult();
		if (user is null) return null;

		if (!passwordHasher.Verify(password, user.PasswordHash)) return null;

		var roles = dbContext.Client.Queryable<UserRoleDataModel>()
			.Where(x => x.UserName == normalizedUserName.Value)
			.Select(x => x.Role)
			.ToList();

		return new AdminCredentialValidationResult(user.Id, user.UserName.Value, user.DisplayName, roles);
	}
}
