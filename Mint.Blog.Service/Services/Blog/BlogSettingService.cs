using System.Net.Mail;
using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Setting;
using Mint.Blog.Model.Entitys.Blog.Setting;
using Mint.Blog.Model.Vos.Blog.Setting;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class BlogSettingService(IBlogSettingRepository repository) : IBlogSettingService {
	public async Task<BlogSettingsDetailVo?> GetAsync(CancellationToken cancellationToken = default){
		var setting = await repository.GetAsync(cancellationToken);
		return setting is null ? null : new BlogSettingsDetailVo(setting.Logo, setting.Name, setting.Author,
			setting.Introduction, setting.CopyrightDeclaration, setting.Avatar, setting.GithubHomepage,
			setting.CsdnHomepage, setting.GiteeHomepage, setting.ZhihuHomepage, setting.DouyinHomepage,
			setting.Mail, setting.IsCommentSensitiveWordOpen, setting.IsCommentExamineOpen, setting.IsAutoTheme);
	}

	public async Task UpdateAsync(UpdateBlogSettingsDto command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Logo), ErrorCodes.BlogSettingLogoInvalid, "Blog logo is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.BlogSettingNameInvalid, "Blog name is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Author), ErrorCodes.BlogSettingAuthorInvalid, "Blog author is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Introduction), ErrorCodes.BlogSettingIntroductionInvalid, "Blog introduction is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Avatar), ErrorCodes.BlogSettingAvatarInvalid, "Blog avatar is required.");
		Guard.Against(!string.IsNullOrWhiteSpace(command.Mail) && !MailAddress.TryCreate(command.Mail.Trim(), out _),
			ErrorCodes.BlogSettingMailInvalid, "Blog mail format is invalid.");
		await repository.SaveAsync(new BlogSettingDataModel {
			Id = 1, Logo = command.Logo.Trim(), Name = command.Name.Trim(), Author = command.Author.Trim(),
			Introduction = command.Introduction.Trim(), CopyrightDeclaration = command.CopyrightDeclaration.Trim(),
			Avatar = command.Avatar.Trim(), GithubHomepage = command.GithubHomepage.Trim(), CsdnHomepage = command.CsdnHomepage.Trim(),
			GiteeHomepage = command.GiteeHomepage.Trim(), ZhihuHomepage = command.ZhihuHomepage.Trim(),
			DouyinHomepage = command.DouyinHomepage.Trim(), Mail = command.Mail.Trim(),
			IsCommentSensitiveWordOpen = command.IsCommentSensitiveWordOpen,
			IsCommentExamineOpen = command.IsCommentExamineOpen, IsAutoTheme = command.IsAutoTheme
		}, cancellationToken);
	}
}
