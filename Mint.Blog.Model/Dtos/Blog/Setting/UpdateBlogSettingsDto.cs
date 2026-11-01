namespace Mint.Blog.Model.Dtos.Blog.Setting;

public sealed record UpdateBlogSettingsDto(
	string Logo, string Name, string Author, string Introduction, string CopyrightDeclaration,
	string Avatar, string GithubHomepage, string CsdnHomepage, string GiteeHomepage,
	string ZhihuHomepage, string DouyinHomepage, string Mail,
	bool IsCommentSensitiveWordOpen, bool IsCommentExamineOpen, bool IsAutoTheme);
