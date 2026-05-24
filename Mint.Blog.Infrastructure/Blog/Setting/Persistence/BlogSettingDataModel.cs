using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Setting.Persistence;

[SugarTable("blog_settings")]
public sealed class BlogSettingDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "logo")]
	public string Logo { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "name")]
	public string Name { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "author")]
	public string Author { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "introduction")]
	public string Introduction { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "copyright_declaration")]
	public string CopyrightDeclaration { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "avatar")]
	public string Avatar { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "github_homepage")]
	public string GithubHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "csdn_homepage")]
	public string CsdnHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "gitee_homepage")]
	public string GiteeHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "zhihu_homepage")]
	public string ZhihuHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "douyin_homepage")]
	public string DouyinHomepage { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "mail")]
	public string Mail { get; set; } = string.Empty;

	[SugarColumn(ColumnName = "is_comment_sensi_word_open")]
	public bool IsCommentSensitiveWordOpen { get; set; }

	[SugarColumn(ColumnName = "is_comment_examine_open")]
	public bool IsCommentExamineOpen { get; set; }

	[SugarColumn(ColumnName = "is_auto_theme")]
	public bool IsAutoTheme { get; set; }
}