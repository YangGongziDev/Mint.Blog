using SqlSugar;

namespace Mint.Blog.Model.Entitys.Blog.Article;

[SugarTable("blog_article_content")]
public sealed class ArticleContentDataModel {
    [SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
    public long Id { get; set; }
    [SugarColumn(ColumnName = "article_id")]
    public long ArticleId { get; set; }
    [SugarColumn(ColumnName = "content", ColumnDataType = "text")]
    public string Content { get; set; } = string.Empty;
}
