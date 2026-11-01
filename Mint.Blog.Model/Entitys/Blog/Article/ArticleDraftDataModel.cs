using SqlSugar;

namespace Mint.Blog.Model.Entitys.Blog.Article;

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
    [SugarColumn(ColumnName = "tag_id", IsNullable = true)]
    public long? TagId { get; set; }
    [SugarColumn(ColumnName = "tag_version_id", IsNullable = true)]
    public long? TagVersionId { get; set; }
    [SugarColumn(ColumnName = "visibility", DefaultValue = "1")]
    public short Visibility { get; set; }
    [SugarColumn(ColumnName = "create_time")]
    public DateTimeOffset CreatedAt { get; set; }
    [SugarColumn(ColumnName = "update_time")]
    public DateTimeOffset UpdatedAt { get; set; }
}

[SugarTable("blog_article_draft_content")]
public sealed class ArticleDraftContentDataModel {
    [SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
    public long Id { get; set; }
    [SugarColumn(ColumnName = "draft_id")]
    public long DraftId { get; set; }
    [SugarColumn(ColumnName = "content", ColumnDataType = "text")]
    public string Content { get; set; } = string.Empty;
}
