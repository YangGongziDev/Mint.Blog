using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Repositories;

namespace Mint.Blog.Application.System.Auth.Logout;

public sealed class LogoutCommandHandler(
	IUserRefreshTokenRepository userRefreshTokenRepository,
	IUnitOfWork unitOfWork) {
	public async Task HandleAsync(LogoutCommand command, CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(command.RefreshToken)) return;

		string rawRefreshToken;
		try {
			rawRefreshToken = RefreshTokenCodec.Decode(command.RefreshToken);
		} catch {
			return;
		}

		var refreshToken = await userRefreshTokenRepository.GetByTokenHashAsync(
			RefreshTokenCodec.ComputeHash(rawRefreshToken),
			cancellationToken);
		if (refreshToken is null || refreshToken.IsRevoked) return;

		refreshToken.Revoke(DateTimeOffset.UtcNow);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await userRefreshTokenRepository.RevokeAsync(refreshToken, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}
}
