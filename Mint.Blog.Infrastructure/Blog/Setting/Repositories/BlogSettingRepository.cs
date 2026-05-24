using Mint.Blog.Application.Blog.Setting.Queries.GetBlogSettingsDetail;
using Mint.Blog.Domain.Blog.Setting.Entities;
using Mint.Blog.Domain.Blog.Setting.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Setting.Persistence;

namespace Mint.Blog.Infrastructure.Blog.Setting.Repositories;

public sealed class BlogSettingRepository(ISqlSugarDbContext dbContext)
	: IBlogSettingRepository, IGetBlogSettingsDetailQueryService {
	public async Task<BlogSetting?> GetAsync(CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<BlogSettingDataModel>()
			.Where(x => x.Id == 1)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task SaveAsync(BlogSetting setting, CancellationToken cancellationToken = default){
		var data = MapToDataModel(setting);
		var exists = await dbContext.Client.Queryable<BlogSettingDataModel>()
			.AnyAsync(x => x.Id == setting.Id);

		if (exists) {
			await dbContext.Client.Updateable(data).ExecuteCommandAsync();
			return;
		}

		await dbContext.Client.Insertable(data).ExecuteCommandAsync();
	}

	async Task<BlogSettingsDetailDto?> IGetBlogSettingsDetailQueryService.GetAsync(CancellationToken cancellationToken){
		var setting = await GetAsync(cancellationToken);
		if (setting is null) return null;

		return new BlogSettingsDetailDto(
			setting.Logo,
			setting.Name,
			setting.Author,
			setting.Introduction,
			setting.CopyrightDeclaration,
			setting.Avatar,
			setting.GithubHomepage,
			setting.CsdnHomepage,
			setting.GiteeHomepage,
			setting.ZhihuHomepage,
			setting.DouyinHomepage,
			setting.Mail,
			setting.IsCommentSensitiveWordOpen,
			setting.IsCommentExamineOpen,
			setting.IsAutoTheme);
	}

	private static BlogSetting MapToDomain(BlogSettingDataModel data){
		return BlogSetting.Rehydrate(
			data.Id,
			data.Logo,
			data.Name,
			data.Author,
			data.Introduction,
			data.CopyrightDeclaration,
			data.Avatar,
			data.GithubHomepage,
			data.CsdnHomepage,
			data.GiteeHomepage,
			data.ZhihuHomepage,
			data.DouyinHomepage,
			data.Mail,
			data.IsCommentSensitiveWordOpen,
			data.IsCommentExamineOpen,
			data.IsAutoTheme);
	}

	private static BlogSettingDataModel MapToDataModel(BlogSetting setting){
		return new BlogSettingDataModel {
			Id = setting.Id,
			Logo = setting.Logo,
			Name = setting.Name,
			Author = setting.Author,
			Introduction = setting.Introduction,
			CopyrightDeclaration = setting.CopyrightDeclaration,
			Avatar = setting.Avatar,
			GithubHomepage = setting.GithubHomepage,
			CsdnHomepage = setting.CsdnHomepage,
			GiteeHomepage = setting.GiteeHomepage,
			ZhihuHomepage = setting.ZhihuHomepage,
			DouyinHomepage = setting.DouyinHomepage,
			Mail = setting.Mail,
			IsCommentSensitiveWordOpen = setting.IsCommentSensitiveWordOpen,
			IsCommentExamineOpen = setting.IsCommentExamineOpen,
			IsAutoTheme = setting.IsAutoTheme
		};
	}
}