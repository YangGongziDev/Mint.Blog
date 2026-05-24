using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Article.Drafts;

[SugarTable("blog_article_draft_content")]
public sealed class ArticleDraftContentDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "draft_id")]
	public long DraftId { get; set; }

	[SugarColumn(ColumnName = "content", ColumnDataType = "text")]
	public string Content { get; set; } = string.Empty;
}
