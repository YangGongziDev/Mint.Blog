using UserRefreshTokenEntity = Mint.Blog.Domain.System.User.Entities.UserRefreshToken;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;
using SqlSugar;

namespace Mint.Blog.Infrastructure.System.User.Persistence.Repositories;

public sealed class UserRefreshTokenRepository(ISqlSugarDbContext dbContext) : IUserRefreshTokenRepository {
	public async Task<long> AddAsync(UserRefreshTokenEntity refreshToken, CancellationToken cancellationToken = default){
		var id = SnowFlakeSingle.Instance.NextId();
		var data = new UserRefreshTokenDataModel {
			Id = id,
			UserId = refreshToken.UserId,
			TokenHash = refreshToken.TokenHash,
			ExpiresAt = refreshToken.ExpiresAt,
			IsRevoked = refreshToken.IsRevoked ? 1 : 0,
			RevokedAt = refreshToken.RevokedAt,
			CreatedAt = refreshToken.CreatedAt
		};

		await dbContext.Client.Insertable(data).ExecuteCommandAsync(cancellationToken);
		return id;
	}

	public async Task<UserRefreshTokenEntity?> GetByTokenHashAsync(string tokenHash, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<UserRefreshTokenDataModel>()
			.Where(x => x.TokenHash == tokenHash)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public Task RevokeAsync(UserRefreshTokenEntity refreshToken, CancellationToken cancellationToken = default){
		return dbContext.Client.Updateable<UserRefreshTokenDataModel>()
			.SetColumns(x => new UserRefreshTokenDataModel {
				IsRevoked = refreshToken.IsRevoked ? 1 : 0,
				RevokedAt = refreshToken.RevokedAt
			})
			.Where(x => x.Id == refreshToken.Id)
			.ExecuteCommandAsync(cancellationToken);
	}

	public Task RevokeAllByUserIdAsync(long userId, CancellationToken cancellationToken = default){
		return dbContext.Client.Updateable<UserRefreshTokenDataModel>()
			.SetColumns(x => new UserRefreshTokenDataModel {
				IsRevoked = 1,
				RevokedAt = DateTimeOffset.UtcNow
			})
			.Where(x => x.UserId == userId && x.IsRevoked == 0)
			.ExecuteCommandAsync(cancellationToken);
	}

	public Task<int> DeleteInvalidTokensCreatedBeforeAsync(DateTimeOffset retentionBoundary,
		CancellationToken cancellationToken = default){
		return dbContext.Client.Deleteable<UserRefreshTokenDataModel>()
			.Where(x => (x.IsRevoked == 1 || x.ExpiresAt < DateTimeOffset.UtcNow) && x.CreatedAt < retentionBoundary)
			.ExecuteCommandAsync(cancellationToken);
	}

	private static UserRefreshTokenEntity MapToDomain(UserRefreshTokenDataModel data){
		return UserRefreshTokenEntity.Rehydrate(
			data.Id,
			data.UserId,
			data.TokenHash,
			data.ExpiresAt,
			data.IsRevoked != 0,
			data.RevokedAt,
			data.CreatedAt);
	}
}
