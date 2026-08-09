using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Article.Drafts;

[SugarTable("blog_article_draft")]
public sealed class ArticleDraftDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "article_id", IsNullable = true)]
	public long? ArticleId { get; set; }

	[SugarColumn(ColumnName = "title")]
	public string Title { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "summary")]
	public string Summary { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "cover", ColumnDataType = "text")]
	public string Cover { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "category_id", IsNullable = true)]
	public long? CategoryId { get; set; }

	[SugarColumn(ColumnName = "visibility", DefaultValue = "1")]
	public short Visibility { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTimeOffset CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTimeOffset UpdatedAt { get; set; }
}
