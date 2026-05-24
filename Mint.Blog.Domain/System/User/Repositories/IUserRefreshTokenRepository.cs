using UserRefreshTokenEntity = Mint.Blog.Domain.System.User.Entities.UserRefreshToken;

namespace Mint.Blog.Domain.System.User.Repositories;

public interface IUserRefreshTokenRepository {
	Task<long> AddAsync(UserRefreshTokenEntity refreshToken, CancellationToken cancellationToken = default);
	Task<UserRefreshTokenEntity?> GetByTokenHashAsync(string tokenHash, CancellationToken cancellationToken = default);
	Task RevokeAsync(UserRefreshTokenEntity refreshToken, CancellationToken cancellationToken = default);
	Task RevokeAllByUserIdAsync(long userId, CancellationToken cancellationToken = default);
	Task DeleteInvalidTokensCreatedBeforeAsync(DateTimeOffset retentionBoundary, CancellationToken cancellationToken = default);
}
