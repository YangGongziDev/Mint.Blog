using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Column.Persistence;

[SugarTable("blog_column")]
public sealed class ColumnDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "title")]
	public string Title { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "cover")]
	public string Cover { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "summary")]
	public string Summary { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }

	[SugarColumn(ColumnName = "is_deleted")]
	public short IsDeleted { get; set; }

	[SugarColumn(ColumnName = "weight")]
	public int Weight { get; set; }

	[SugarColumn(ColumnName = "is_publish")]
	public short IsPublish { get; set; }

	[SugarColumn(ColumnName = "sort")]
	public int Sort { get; set; }
}