using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Domain.System.User.ValueObjects;

namespace Mint.Blog.Application.System.User.Commands;

public sealed record ChangeOwnPasswordCommand(string OldPassword, string NewPassword);

public sealed class ChangeOwnPasswordHandler(IUserRepository users, IUserRefreshTokenRepository refreshTokens, IPasswordHasher hasher, IUnitOfWork unitOfWork) {
	public async Task HandleAsync(string username, ChangeOwnPasswordCommand command, CancellationToken cancellationToken){
		Guard.Against(string.IsNullOrEmpty(command.NewPassword) || command.NewPassword.Length < 12 || command.NewPassword.Length > 64,
			ErrorCodes.UserPasswordInvalid, "新密码长度须为 12 至 64 个字符");
		var user = await users.GetByUserNameAsync(UserName.Create(username), cancellationToken);
		Guard.Against(user is null, ErrorCodes.Unauthorized, "账号不存在或已禁用");
		Guard.Against(string.IsNullOrEmpty(command.OldPassword) || !hasher.Verify(command.OldPassword, user!.PasswordHash), ErrorCodes.UserPasswordInvalid, "原密码错误");
		user!.UpdatePassword(hasher.Hash(command.NewPassword));
		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await users.UpdateAsync(user, cancellationToken);
			await refreshTokens.RevokeAllByUserIdAsync(user.Id, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}
}
