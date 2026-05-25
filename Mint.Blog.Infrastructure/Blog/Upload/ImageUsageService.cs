using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Blog.Article.Drafts;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Column.Persistence;
using Mint.Blog.Infrastructure.Blog.Friend.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Setting.Persistence;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class ImageUsageService(ISqlSugarDbContext dbContext) : IImageUsageService {
	public async Task<bool> IsUsedAsync(string imageUrl, CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(imageUrl)) return false;

		var image = imageUrl.Trim();
		var articleCoverUsed = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.Cover == image)
			.AnyAsync();
		if (articleCoverUsed) return true;

		var articleContentUsed = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.Where(x => x.Content.Contains(image))
			.AnyAsync();
		if (articleContentUsed) return true;

		var draftCoverUsed = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(x => x.Cover == image)
			.AnyAsync();
		if (draftCoverUsed) return true;

		var columnCoverUsed = await dbContext.Client.Queryable<ColumnDataModel>()
			.Where(x => x.Cover == image)
			.AnyAsync();
		if (columnCoverUsed) return true;

		var draftContentUsed = await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.Where(x => x.Content.Contains(image))
			.AnyAsync();
		if (draftContentUsed) return true;

		var settingUsed = await dbContext.Client.Queryable<BlogSettingDataModel>()
			.Where(x => x.Logo == image || x.Avatar == image)
			.AnyAsync();
		if (settingUsed) return true;

		return await dbContext.Client.Queryable<FriendDataModel>()
			.Where(x => x.Avatar == image)
			.AnyAsync();
	}
}
