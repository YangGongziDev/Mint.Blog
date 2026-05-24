using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Blog.Article.Drafts;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Setting.Persistence;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class ImageReferenceUpdateService(ISqlSugarDbContext dbContext) : IImageReferenceUpdateService {
	public async Task ReplaceAsync(string oldImageUrl, string newImageUrl, CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(oldImageUrl) || string.IsNullOrWhiteSpace(newImageUrl) || oldImageUrl == newImageUrl)
			return;

		await ReplaceArticleCoversAsync(oldImageUrl, newImageUrl, cancellationToken);
		await ReplaceArticleContentsAsync(oldImageUrl, newImageUrl, cancellationToken);
		await ReplaceDraftCoversAsync(oldImageUrl, newImageUrl, cancellationToken);
		await ReplaceDraftContentsAsync(oldImageUrl, newImageUrl, cancellationToken);
		await ReplaceBlogSettingsAsync(oldImageUrl, newImageUrl, cancellationToken);
	}

	private Task ReplaceArticleCoversAsync(string oldImageUrl, string newImageUrl, CancellationToken cancellationToken){
		return dbContext.Client.Updateable<ArticleDataModel>()
			.SetColumns(article => new ArticleDataModel { Cover = newImageUrl })
			.Where(article => article.Cover == oldImageUrl)
			.ExecuteCommandAsync(cancellationToken);
	}

	private async Task ReplaceArticleContentsAsync(string oldImageUrl, string newImageUrl,
		CancellationToken cancellationToken){
		var contents = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.Where(content => content.Content.Contains(oldImageUrl))
			.ToListAsync(cancellationToken);

		foreach (var content in contents) {
			content.Content = content.Content.Replace(oldImageUrl, newImageUrl, StringComparison.Ordinal);
			await dbContext.Client.Updateable(content)
				.UpdateColumns(item => new { item.Content })
				.ExecuteCommandAsync(cancellationToken);
		}
	}

	private Task ReplaceDraftCoversAsync(string oldImageUrl, string newImageUrl, CancellationToken cancellationToken){
		return dbContext.Client.Updateable<ArticleDraftDataModel>()
			.SetColumns(draft => new ArticleDraftDataModel { Cover = newImageUrl })
			.Where(draft => draft.Cover == oldImageUrl)
			.ExecuteCommandAsync(cancellationToken);
	}

	private async Task ReplaceDraftContentsAsync(string oldImageUrl, string newImageUrl,
		CancellationToken cancellationToken){
		var contents = await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.Where(content => content.Content.Contains(oldImageUrl))
			.ToListAsync(cancellationToken);

		foreach (var content in contents) {
			content.Content = content.Content.Replace(oldImageUrl, newImageUrl, StringComparison.Ordinal);
			await dbContext.Client.Updateable(content)
				.UpdateColumns(item => new { item.Content })
				.ExecuteCommandAsync(cancellationToken);
		}
	}

	private async Task ReplaceBlogSettingsAsync(string oldImageUrl, string newImageUrl, CancellationToken cancellationToken){
		var settings = await dbContext.Client.Queryable<BlogSettingDataModel>()
			.Where(setting => setting.Logo == oldImageUrl || setting.Avatar == oldImageUrl)
			.ToListAsync(cancellationToken);

		foreach (var setting in settings) {
			if (setting.Logo == oldImageUrl) setting.Logo = newImageUrl;
			if (setting.Avatar == oldImageUrl) setting.Avatar = newImageUrl;

			await dbContext.Client.Updateable(setting)
				.UpdateColumns(item => new { item.Logo, item.Avatar })
				.ExecuteCommandAsync(cancellationToken);
		}
	}
}
