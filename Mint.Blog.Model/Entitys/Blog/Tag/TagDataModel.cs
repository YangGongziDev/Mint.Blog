using SqlSugar;

namespace Mint.Blog.Model.Entitys.Blog.Tag;

[SugarTable("blog_tag")]
public sealed class TagDataModel {
    [SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
    public long Id { get; set; }
    [SugarColumn(ColumnName = "category_id")]
    public long CategoryId { get; set; }
    [SugarColumn(ColumnName = "name")]
    public string Name { get; set; } = string.Empty;
    [SugarColumn(ColumnName = "logo_url")]
    public string LogoUrl { get; set; } = string.Empty;
    [SugarColumn(ColumnName = "show_in_navigation")]
    public short ShowInNavigation { get; set; }
    [SugarColumn(ColumnName = "navigation_description")]
    public string NavigationDescription { get; set; } = string.Empty;
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
