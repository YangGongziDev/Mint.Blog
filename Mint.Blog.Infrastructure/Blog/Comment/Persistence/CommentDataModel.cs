using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Comment.Persistence;

[SugarTable("blog_comment")]
public sealed class CommentDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "content")]
	public string Content { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "avatar")]
	public string Avatar { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "nickname")]
	public string Nickname { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "mail")]
	public string Mail { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "website")]
	public string Website { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "router_url")]
	public string RouterUrl { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }

	[SugarColumn(ColumnName = "is_deleted")]
	public short IsDeleted { get; set; }

	[SugarColumn(ColumnName = "reply_comment_id")]
	public long? ReplyCommentId { get; set; }

	[SugarColumn(ColumnName = "parent_comment_id")]
	public long? ParentCommentId { get; set; }

	[SugarColumn(ColumnName = "status")]
	public int Status { get; set; }

	[SugarColumn(ColumnName = "reason")]
	public string Reason { get; set; } = string.Empty;
}