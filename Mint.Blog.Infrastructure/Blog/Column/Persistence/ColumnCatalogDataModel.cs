using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Column.Persistence;

[SugarTable("blog_column_catalog")]
public sealed class ColumnCatalogDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "column_id")]
	public long ColumnId { get; set; }

	[SugarColumn(ColumnName = "article_id")]
	public long ArticleId { get; set; }

	[SugarColumn(ColumnName = "title")]
	public string Title { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "level")]
	public int Level { get; set; }

	[SugarColumn(ColumnName = "parent_id")]
	public long? ParentId { get; set; }

	[SugarColumn(ColumnName = "sort")]
	public int Sort { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }

	[SugarColumn(ColumnName = "is_deleted")]
	public short IsDeleted { get; set; }
}