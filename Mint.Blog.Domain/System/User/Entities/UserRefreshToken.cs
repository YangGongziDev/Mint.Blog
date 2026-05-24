using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.System.User.Entities;

public sealed class UserRefreshToken : AggregateRoot<long> {
	public UserRefreshToken(){
		TokenHash = string.Empty;
		CreatedAt = DateTimeOffset.UtcNow;
		ExpiresAt = DateTimeOffset.UtcNow;
	}

	private UserRefreshToken(long id, long userId, string tokenHash, DateTimeOffset expiresAt, bool isRevoked,
		DateTimeOffset? revokedAt, DateTimeOffset createdAt){
		Id = id;
		UserId = userId;
		TokenHash = tokenHash;
		ExpiresAt = expiresAt;
		IsRevoked = isRevoked;
		RevokedAt = revokedAt;
		CreatedAt = createdAt;
	}

	public override long Id { get; protected set; }
	public long UserId { get; private set; }
	public string TokenHash { get; private set; }
	public DateTimeOffset ExpiresAt { get; private set; }
	public bool IsRevoked { get; private set; }
	public DateTimeOffset? RevokedAt { get; private set; }
	public DateTimeOffset CreatedAt { get; private set; }

	public static UserRefreshToken Create(long userId, string tokenHash, DateTimeOffset expiresAt){
		return new UserRefreshToken(0, userId, tokenHash, expiresAt, false, null, DateTimeOffset.UtcNow);
	}

	public static UserRefreshToken Rehydrate(long id, long userId, string tokenHash, DateTimeOffset expiresAt,
		bool isRevoked, DateTimeOffset? revokedAt, DateTimeOffset createdAt){
		return new UserRefreshToken(id, userId, tokenHash, expiresAt, isRevoked, revokedAt, createdAt);
	}

	public bool IsActiveAt(DateTimeOffset now){
		return !IsRevoked && ExpiresAt > now;
	}

	public void Revoke(DateTimeOffset revokedAt){
		if (IsRevoked) return;

		IsRevoked = true;
		RevokedAt = revokedAt;
	}
}
