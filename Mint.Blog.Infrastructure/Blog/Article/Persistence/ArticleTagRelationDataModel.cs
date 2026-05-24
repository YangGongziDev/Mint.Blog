using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Article.Persistence;

[SugarTable("blog_article_tag_rel")]
public sealed class ArticleTagRelationDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "article_id")]
	public long ArticleId { get; set; }

	[SugarColumn(ColumnName = "tag_id")]
	public long TagId { get; set; }
}