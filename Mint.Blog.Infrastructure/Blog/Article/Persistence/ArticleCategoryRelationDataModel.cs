using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Article.Persistence;

[SugarTable("blog_article_category_rel")]
public sealed class ArticleCategoryRelationDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "article_id")]
	public long ArticleId { get; set; }

	[SugarColumn(ColumnName = "category_id")]
	public long CategoryId { get; set; }
}