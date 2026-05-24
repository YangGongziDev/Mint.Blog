using System.Text.RegularExpressions;
using Microsoft.Extensions.Options;
using Minio;
using Minio.DataModel.Args;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Upload.Images;
using Mint.Blog.Infrastructure.Blog.Article.Drafts;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Setting.Persistence;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class ManagedImageQueryService(
	IMinioClient minioClient,
	IOptions<MinioOptions> minioOptions,
	ISqlSugarDbContext dbContext) : IManagedImageQueryService {
	private static readonly HashSet<string> ImageExtensions = new(StringComparer.OrdinalIgnoreCase) {
		".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".svg", ".ico", ".avif"
	};

	public async Task<PagedResult<ManagedImageListItemDto>> GetAsync(ManagedImageListQuery query,
		CancellationToken cancellationToken = default){
		var pageNumber = Math.Max(query.PageNumber, 1);
		var pageSize = Math.Clamp(query.PageSize, 1, 200);
		var bucketName = string.IsNullOrWhiteSpace(query.BucketName)
			? minioOptions.Value.BucketName
			: query.BucketName.Trim();

		var objects = await GetImageObjectsAsync(bucketName, cancellationToken);
		if (!string.IsNullOrWhiteSpace(query.FileName)) {
			var keyword = query.FileName.Trim();
			objects = objects
				.Where(item => item.ObjectName.Contains(keyword, StringComparison.OrdinalIgnoreCase))
				.ToList();
		}

		var items = new List<ManagedImageListItemDto>();
		foreach (var item in objects) {
			var url = BuildObjectUrl(bucketName, item.ObjectName);
			var references = await GetReferencedArticlesAsync(url);
			if (query.Used.HasValue && query.Used.Value != references.Count > 0) continue;

			items.Add(new ManagedImageListItemDto(
				bucketName,
				item.ObjectName,
				Path.GetFileName(item.ObjectName),
				url,
				item.Size,
				item.LastModified,
				references));
		}

		var totalCount = items.Count;
		var pageItems = items
			.Skip((pageNumber - 1) * pageSize)
			.Take(pageSize)
			.ToArray();

		return new PagedResult<ManagedImageListItemDto>(pageItems, pageNumber, pageSize, totalCount);
	}

	private async Task<List<ManagedImageObject>> GetImageObjectsAsync(string bucketName, CancellationToken cancellationToken){
		var result = new List<ManagedImageObject>();
		await foreach (var item in minioClient.ListObjectsEnumAsync(new ListObjectsArgs()
			.WithBucket(bucketName)
			.WithRecursive(true), cancellationToken)) {
			if (item.IsDir || !IsImageObject(item.Key)) continue;

			result.Add(new ManagedImageObject(item.Key, item.Size > long.MaxValue ? long.MaxValue : (long)item.Size, item.LastModifiedDateTime));
		}

		return result.OrderByDescending(item => item.LastModified ?? DateTime.MinValue).ToList();
	}

	private async Task<IReadOnlyCollection<ManagedImageArticleReferenceDto>> GetReferencedArticlesAsync(string imageUrl){
		var references = new Dictionary<long, ManagedImageArticleReferenceDto>();

		var coverArticles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(article => article.Cover == imageUrl)
			.Select(article => new { article.Id, article.Title })
			.ToListAsync();
		foreach (var article in coverArticles) AddReference(references, article.Id, article.Title);

		var contentArticles = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.InnerJoin<ArticleDataModel>((content, article) => content.ArticleId == article.Id)
			.Where(content => content.Content.Contains(imageUrl))
			.Select((content, article) => new { article.Id, article.Title })
			.ToListAsync();
		foreach (var article in contentArticles) AddReference(references, article.Id, article.Title);

		var draftCoverArticles = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(draft => draft.ArticleId != null && draft.Cover == imageUrl)
			.Select(draft => new { ArticleId = draft.ArticleId!.Value, draft.Title })
			.ToListAsync();
		foreach (var article in draftCoverArticles) AddReference(references, article.ArticleId, article.Title);

		var draftContentArticles = await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.InnerJoin<ArticleDraftDataModel>((content, draft) => content.DraftId == draft.Id)
			.Where((content, draft) => draft.ArticleId != null && content.Content.Contains(imageUrl))
			.Select((content, draft) => new { ArticleId = draft.ArticleId!.Value, draft.Title })
			.ToListAsync();
		foreach (var article in draftContentArticles) AddReference(references, article.ArticleId, article.Title);

		var setting = await dbContext.Client.Queryable<BlogSettingDataModel>()
			.Select(x => new { x.Name, x.Logo, x.Avatar })
			.SingleAsync();
		if (setting is not null) {
			if (setting.Logo == imageUrl) {
				AddReference(references, -1, $"博客 LOGO：{setting.Name}", "/blog/admin/blog-settings");
			}

			if (setting.Avatar == imageUrl) {
				AddReference(references, -2, $"作者头像：{setting.Name}", "/blog/admin/blog-settings");
			}
		}

		return references.Values.ToArray();
	}

	private static void AddReference(IDictionary<long, ManagedImageArticleReferenceDto> references, long articleId,
		string title, string? url = null){
		if (references.ContainsKey(articleId)) return;

		references[articleId] = new ManagedImageArticleReferenceDto(
			articleId.ToString(),
			string.IsNullOrWhiteSpace(title) ? $"文章 {articleId}" : title,
			url ?? $"/blog/surfer/article/{articleId}");
	}

	private string BuildObjectUrl(string bucketName, string objectName){
		var publicEndpoint = string.IsNullOrWhiteSpace(minioOptions.Value.PublicEndpoint)
			? minioOptions.Value.Endpoint
			: minioOptions.Value.PublicEndpoint;

		return $"{publicEndpoint.TrimEnd('/')}/{bucketName}/{Uri.EscapeDataString(objectName).Replace("%2F", "/")}";
	}

	private static bool IsImageObject(string objectName){
		var extension = Path.GetExtension(objectName);
		if (!string.IsNullOrWhiteSpace(extension) && ImageExtensions.Contains(extension)) return true;

		return Regex.IsMatch(objectName, @"\.(jpg|jpeg|png|gif|webp|bmp|svg|ico|avif)(\?.*)?$",
			RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
	}

	private sealed record ManagedImageObject(string ObjectName, long Size, DateTime? LastModified);
}
