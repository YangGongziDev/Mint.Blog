using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Setting.Entities;

public sealed class BlogSetting : AggregateRoot<long> {
	public BlogSetting(){
		Logo = string.Empty;
		Name = string.Empty;
		Author = string.Empty;
		Introduction = string.Empty;
		CopyrightDeclaration = string.Empty;
		Avatar = string.Empty;
		GithubHomepage = string.Empty;
		CsdnHomepage = string.Empty;
		GiteeHomepage = string.Empty;
		ZhihuHomepage = string.Empty;
		DouyinHomepage = string.Empty;
		Mail = string.Empty;
	}

	private BlogSetting(
		long id,
		string logo,
		string name,
		string author,
		string introduction,
		string copyrightDeclaration,
		string avatar,
		string githubHomepage,
		string csdnHomepage,
		string giteeHomepage,
		string zhihuHomepage,
		string douyinHomepage,
		string mail,
		bool isCommentSensitiveWordOpen,
		bool isCommentExamineOpen,
		bool isAutoTheme){
		Id = id;
		Logo = logo;
		Name = name;
		Author = author;
		Introduction = introduction;
		CopyrightDeclaration = copyrightDeclaration;
		Avatar = avatar;
		GithubHomepage = githubHomepage;
		CsdnHomepage = csdnHomepage;
		GiteeHomepage = giteeHomepage;
		ZhihuHomepage = zhihuHomepage;
		DouyinHomepage = douyinHomepage;
		Mail = mail;
		IsCommentSensitiveWordOpen = isCommentSensitiveWordOpen;
		IsCommentExamineOpen = isCommentExamineOpen;
		IsAutoTheme = isAutoTheme;
	}

	public override long Id { get; protected set; }
	public string Logo { get; private set; }
	public string Name { get; private set; }
	public string Author { get; private set; }
	public string Introduction { get; private set; }
	public string CopyrightDeclaration { get; private set; }
	public string Avatar { get; private set; }
	public string GithubHomepage { get; private set; }
	public string CsdnHomepage { get; private set; }
	public string GiteeHomepage { get; private set; }
	public string ZhihuHomepage { get; private set; }
	public string DouyinHomepage { get; private set; }
	public string Mail { get; private set; }
	public bool IsCommentSensitiveWordOpen { get; private set; }
	public bool IsCommentExamineOpen { get; private set; }
	public bool IsAutoTheme { get; private set; }

	public static BlogSetting Rehydrate(
		long id,
		string logo,
		string name,
		string author,
		string introduction,
		string copyrightDeclaration,
		string avatar,
		string githubHomepage,
		string csdnHomepage,
		string giteeHomepage,
		string zhihuHomepage,
		string douyinHomepage,
		string mail,
		bool isCommentSensitiveWordOpen,
		bool isCommentExamineOpen,
		bool isAutoTheme){
		return new BlogSetting(
			id,
			logo,
			name,
			author,
			introduction,
			copyrightDeclaration,
			avatar,
			githubHomepage,
			csdnHomepage,
			giteeHomepage,
			zhihuHomepage,
			douyinHomepage,
			mail,
			isCommentSensitiveWordOpen,
			isCommentExamineOpen,
			isAutoTheme);
	}
}