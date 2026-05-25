using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Setting.Persistence;

[SugarTable("blog_settings")]
public sealed class BlogSettingDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "logo", ColumnDataType = "text")]
	public string Logo { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "name", ColumnDataType = "varchar(200)")]
	public string Name { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "author", ColumnDataType = "varchar(200)")]
	public string Author { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "introduction", ColumnDataType = "text")]
	public string Introduction { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "copyright_declaration", ColumnDataType = "text")]
	public string CopyrightDeclaration { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "avatar", ColumnDataType = "text")]
	public string Avatar { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "github_homepage", ColumnDataType = "text")]
	public string GithubHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "csdn_homepage", ColumnDataType = "text")]
	public string CsdnHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "gitee_homepage", ColumnDataType = "text")]
	public string GiteeHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "zhihu_homepage", ColumnDataType = "text")]
	public string ZhihuHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "douyin_homepage", ColumnDataType = "text")]
	public string DouyinHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "mail", ColumnDataType = "varchar(200)")]
	public string Mail { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "is_comment_sensi_word_open")]
	public bool IsCommentSensitiveWordOpen { get; set; }

	[SugarColumn(ColumnName = "is_comment_examine_open")]
	public bool IsCommentExamineOpen { get; set; }

	[SugarColumn(ColumnName = "is_auto_theme")]
	public bool IsAutoTheme { get; set; }
}