using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Article.Persistence;

[SugarTable("blog_article")]
public sealed class ArticleDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "title")]
	public string Title { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "cover", ColumnDataType = "text")]
	public string Cover { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "summary")]
	public string Summary { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }

	[SugarColumn(ColumnName = "is_deleted")]
	public short IsDeleted { get; set; }

	[SugarColumn(ColumnName = "read_num")]
	public long ReadCount { get; set; }

	[SugarColumn(ColumnName = "weight")]
	public int Weight { get; set; }

	[SugarColumn(ColumnName = "type")]
	public int Type { get; set; }

	[SugarColumn(IsIgnore = true)]
	public string Content { get; set; } = string.Empty;

	[SugarColumn(IsIgnore = true)]
	public long CategoryId { get; set; }

	[SugarColumn(IsIgnore = true)]
	public bool IsTop { get; set; }
}