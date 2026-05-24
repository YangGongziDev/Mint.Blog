using SqlSugar;

namespace Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;

[SugarTable("sys_user_refresh_token")]
public sealed class UserRefreshTokenDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "user_id")]
	public long UserId { get; set; }

	[SugarColumn(ColumnName = "token_hash")]
	public string TokenHash { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "expires_at")]
	public DateTimeOffset ExpiresAt { get; set; }

	[SugarColumn(ColumnName = "is_revoked")]
	public int IsRevoked { get; set; }

	[SugarColumn(ColumnName = "revoked_at", IsNullable = true)]
	public DateTimeOffset? RevokedAt { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }
}
