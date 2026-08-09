using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Gallery.Persistence;

[SugarTable("blog_gallery_image")]
public sealed class GalleryImageDataModel {
	[SugarColumn(IsPrimaryKey = true, IsIdentity = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "name")]
	public string Name { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "category_id")]
	public long CategoryId { get; set; }

	[SugarColumn(ColumnName = "resolution")]
	public string Resolution { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "ratio")]
	public string Ratio { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "image_time")]
	public DateTime? Time { get; set; }

	[SugarColumn(ColumnName = "url")]
	public string Url { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "source_type")]
	public string SourceType { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "bucket_name")]
	public string BucketName { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "object_name")]
	public string ObjectName { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "file_name")]
	public string FileName { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "size")]
	public int Size { get; set; }

	[SugarColumn(ColumnName = "sort")]
	public int Sort { get; set; }

	[SugarColumn(ColumnName = "enabled")]
	public bool Enabled { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }
}
