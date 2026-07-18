using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Gallery.Persistence;

[SugarTable("blog_gallery_category")]
public sealed class GalleryCategoryDataModel {
	[SugarColumn(IsPrimaryKey = true, IsIdentity = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "name")]
	public string Name { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "description")]
	public string Description { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "sort")]
	public int Sort { get; set; }

	[SugarColumn(ColumnName = "enabled")]
	public bool Enabled { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }
}
