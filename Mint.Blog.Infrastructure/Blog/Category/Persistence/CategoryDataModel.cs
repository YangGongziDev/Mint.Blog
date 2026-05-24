using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Category.Persistence;

[SugarTable("blog_category")]
public sealed class CategoryDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "name")]
	public string Name { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }

	[SugarColumn(ColumnName = "is_deleted")]
	public short IsDeleted { get; set; }

	[SugarColumn(ColumnName = "articles_total")]
	public int ArticlesTotal { get; set; }

	[SugarColumn(ColumnName = "sort")]
	public long? Sort { get; set; }
}