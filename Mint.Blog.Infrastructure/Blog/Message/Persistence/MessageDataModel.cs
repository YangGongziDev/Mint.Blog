using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Message.Persistence;

[SugarTable("blog_message")]
public sealed class MessageDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "nickname")]
	public string Nickname { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "email", IsNullable = true)]
	public string? Email { get; set; }

	[SugarColumn(ColumnName = "website", IsNullable = true)]
	public string? Website { get; set; }

	[SugarColumn(ColumnName = "content")]
	public string Content { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "color")]
	public string Color { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "is_published")]
	public bool IsPublished { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }
}
