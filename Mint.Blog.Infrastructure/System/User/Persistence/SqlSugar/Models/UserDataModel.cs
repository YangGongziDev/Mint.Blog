using SqlSugar;

namespace Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;

[SugarTable("sys_user")]
public sealed class UserDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "username")]
	public string UserName { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "display_name")]
	public string DisplayName { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "password")]
	public string Password { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "is_deleted")]
	public int IsDeleted { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }

}