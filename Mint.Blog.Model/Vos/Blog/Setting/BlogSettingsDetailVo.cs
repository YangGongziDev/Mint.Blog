namespace Mint.Blog.Model.Vos.Blog.Setting;

public sealed record BlogSettingsDetailVo(
	string Logo, string Name, string Author, string Introduction, string CopyrightDeclaration,
	string Avatar, string GithubHomepage, string CsdnHomepage, string GiteeHomepage,
	string ZhihuHomepage, string DouyinHomepage, string Mail,
	bool IsCommentSensitiveWordOpen, bool IsCommentExamineOpen, bool IsAutoTheme);
