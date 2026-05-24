using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.Entities;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Domain.System.User.ValueObjects;

namespace Mint.Blog.Application.System.Auth.Login;

public sealed class LoginCommandHandler(
	ITokenService tokenService,
	IAdminCredentialValidator adminCredentialValidator,
	IUserRefreshTokenRepository userRefreshTokenRepository,
	IUnitOfWork unitOfWork) {
	private static readonly TimeSpan AccessTokenLifetime = TimeSpan.FromHours(2);
	private static readonly TimeSpan RefreshTokenLifetime = TimeSpan.FromDays(7);
	private static readonly TimeSpan InvalidRefreshTokenRetention = TimeSpan.FromDays(30);

	public async Task<LoginResult> HandleAsync(LoginCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.UserName), ErrorCodes.LoginInvalid, "User name is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Password), ErrorCodes.LoginInvalid, "Password is required.");

		var userName = UserName.Create(command.UserName).Value;
		var password = command.Password.Trim();
		var validationResult = adminCredentialValidator.Validate(userName, password);

		Guard.Against(validationResult is null, ErrorCodes.LoginInvalid, "Invalid user name or password.");

		var now = DateTimeOffset.UtcNow;
		var expiresAt = now.Add(AccessTokenLifetime);
		var refreshTokenExpiresAt = now.Add(RefreshTokenLifetime);
		var accessToken = tokenService.GenerateAccessToken(validationResult!.UserId, validationResult.UserName, validationResult.Roles);
		var refreshTokenValue = tokenService.GenerateRefreshToken();
		var refreshTokenHash = RefreshTokenCodec.ComputeHash(refreshTokenValue);
		var refreshToken = UserRefreshToken.Create(validationResult.UserId, refreshTokenHash, refreshTokenExpiresAt);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await userRefreshTokenRepository.DeleteInvalidTokensCreatedBeforeAsync(
				now.Subtract(InvalidRefreshTokenRetention),
				cancellationToken);
			await userRefreshTokenRepository.RevokeAllByUserIdAsync(validationResult.UserId, cancellationToken);
			await userRefreshTokenRepository.AddAsync(refreshToken, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}

		return new LoginResult(
			accessToken,
			RefreshTokenCodec.Encode(refreshTokenValue),
			expiresAt,
			refreshTokenExpiresAt,
			validationResult.UserName,
			validationResult.DisplayName);
	}
}
