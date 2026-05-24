using System.Net.Mail;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Setting.Entities;
using Mint.Blog.Domain.Blog.Setting.Repositories;

namespace Mint.Blog.Application.Blog.Setting.Commands.UpdateBlogSettings;

public sealed class UpdateBlogSettingsCommandHandler(IBlogSettingRepository blogSettingRepository) {
	public async Task HandleAsync(UpdateBlogSettingsCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Logo), ErrorCodes.BlogSettingLogoInvalid,
			"Blog logo is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.BlogSettingNameInvalid,
			"Blog name is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Author), ErrorCodes.BlogSettingAuthorInvalid,
			"Blog author is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Introduction), ErrorCodes.BlogSettingIntroductionInvalid,
			"Blog introduction is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Avatar), ErrorCodes.BlogSettingAvatarInvalid,
			"Blog avatar is required.");
		Guard.Against(!string.IsNullOrWhiteSpace(command.Mail) && !MailAddress.TryCreate(command.Mail.Trim(), out _),
			ErrorCodes.BlogSettingMailInvalid, "Blog mail format is invalid.");

		var setting = BlogSetting.Rehydrate(
			1,
			command.Logo.Trim(),
			command.Name.Trim(),
			command.Author.Trim(),
			command.Introduction.Trim(),
			command.CopyrightDeclaration.Trim(),
			command.Avatar.Trim(),
			command.GithubHomepage.Trim(),
			command.CsdnHomepage.Trim(),
			command.GiteeHomepage.Trim(),
			command.ZhihuHomepage.Trim(),
			command.DouyinHomepage.Trim(),
			command.Mail.Trim(),
			command.IsCommentSensitiveWordOpen,
			command.IsCommentExamineOpen,
			command.IsAutoTheme);

		await blogSettingRepository.SaveAsync(setting, cancellationToken);
	}
}