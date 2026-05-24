namespace Mint.Blog.Application.Blog.Setting.Queries.GetBlogSettingsDetail;

public sealed record BlogSettingsDetailDto(
	string Logo,
	string Name,
	string Author,
	string Introduction,
	string CopyrightDeclaration,
	string Avatar,
	string GithubHomepage,
	string CsdnHomepage,
	string GiteeHomepage,
	string ZhihuHomepage,
	string DouyinHomepage,
	string Mail,
	bool IsCommentSensitiveWordOpen,
	bool IsCommentExamineOpen,
	bool IsAutoTheme);