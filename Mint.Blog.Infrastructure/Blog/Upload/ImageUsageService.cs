using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Blog.Article.Drafts;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;

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

		return await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.Where(x => x.Content.Contains(image))
			.AnyAsync();
	}
}
