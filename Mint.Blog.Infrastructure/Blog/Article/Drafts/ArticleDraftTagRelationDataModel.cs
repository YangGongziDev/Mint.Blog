using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Article.Drafts;

[SugarTable("blog_article_draft_tag")]
public sealed class ArticleDraftTagRelationDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "draft_id")]
	public long DraftId { get; set; }

	[SugarColumn(ColumnName = "tag_id")]
	public long TagId { get; set; }
}
