using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Friend.Persistence;

[SugarTable("blog_friend")]
public sealed class FriendDataModel {
	[SugarColumn(IsPrimaryKey = true, IsIdentity = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "name")]
	public string Name { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "description")]
	public string Description { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "url")]
	public string Url { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "avatar")]
	public string Avatar { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "status")]
	public string Status { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "category")]
	public string Category { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "is_top")]
	public bool IsTop { get; set; }

	[SugarColumn(ColumnName = "email")]
	public string Email { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "sort")]
	public int Sort { get; set; }

	[SugarColumn(ColumnName = "is_deleted")]
	public short IsDeleted { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }
}