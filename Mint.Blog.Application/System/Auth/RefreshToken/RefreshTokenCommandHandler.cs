using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Entities;
using Mint.Blog.Domain.System.User.Repositories;

namespace Mint.Blog.Application.System.Auth.RefreshToken;

public sealed class RefreshTokenCommandHandler(
	ITokenService tokenService,
	IUserRefreshTokenRepository userRefreshTokenRepository,
	IUserRepository userRepository,
	IUnitOfWork unitOfWork) {
	private static readonly TimeSpan AccessTokenLifetime = TimeSpan.FromHours(2);
	private static readonly TimeSpan RefreshTokenLifetime = TimeSpan.FromDays(7);
	private static readonly TimeSpan InvalidRefreshTokenRetention = TimeSpan.FromDays(30);
	private const string RefreshTokenExpiredMessage = "刷新登录已失效，请重新登录。";

	public async Task<Login.LoginResult> HandleAsync(RefreshTokenCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.RefreshToken), ErrorCodes.RefreshTokenInvalid, "Refresh token is required.");

		var rawRefreshToken = DecodeRefreshToken(command.RefreshToken);
		var refreshTokenHash = RefreshTokenCodec.ComputeHash(rawRefreshToken);
		var currentRefreshToken = await userRefreshTokenRepository.GetByTokenHashAsync(refreshTokenHash, cancellationToken);

		if (currentRefreshToken is null || !currentRefreshToken.IsActiveAt(DateTimeOffset.UtcNow)) {
			throw new BusinessException(ErrorCodes.RefreshTokenInvalid, RefreshTokenExpiredMessage);
		}

		var user = await userRepository.GetByIdAsync(currentRefreshToken.UserId, cancellationToken);
		if (user is null) {
			throw new BusinessException(ErrorCodes.RefreshTokenInvalid, RefreshTokenExpiredMessage);
		}

		var now = DateTimeOffset.UtcNow;
		var accessTokenExpiresAt = now.Add(AccessTokenLifetime);
		var newRefreshTokenExpiresAt = now.Add(RefreshTokenLifetime);
		var roles = await userRepository.GetRolesAsync(user.UserName.Value, cancellationToken);
		var accessToken = tokenService.GenerateAccessToken(user.Id, user.UserName.Value, roles);
		var newRefreshTokenValue = tokenService.GenerateRefreshToken();
		var newRefreshToken = UserRefreshToken.Create(
			user.Id,
			RefreshTokenCodec.ComputeHash(newRefreshTokenValue),
			newRefreshTokenExpiresAt);

		currentRefreshToken.Revoke(now);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await userRefreshTokenRepository.DeleteInvalidTokensCreatedBeforeAsync(
				now.Subtract(InvalidRefreshTokenRetention),
				cancellationToken);
			await userRefreshTokenRepository.RevokeAsync(currentRefreshToken, cancellationToken);
			await userRefreshTokenRepository.AddAsync(newRefreshToken, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}

		return new Login.LoginResult(
			accessToken,
			RefreshTokenCodec.Encode(newRefreshTokenValue),
			accessTokenExpiresAt,
			newRefreshTokenExpiresAt,
			user.UserName.Value,
			user.DisplayName);
	}

	private static string DecodeRefreshToken(string refreshToken){
		try {
			return RefreshTokenCodec.Decode(refreshToken);
		} catch {
			throw new BusinessException(ErrorCodes.RefreshTokenInvalid, RefreshTokenExpiredMessage);
		}
	}
}
