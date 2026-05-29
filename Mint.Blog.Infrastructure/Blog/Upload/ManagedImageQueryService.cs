using System.Text.RegularExpressions;
using Amazon.S3;
using Amazon.S3.Model;
using Microsoft.Extensions.Options;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Upload.Images;
using Mint.Blog.Infrastructure.Blog.Article.Drafts;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Column.Persistence;
using Mint.Blog.Infrastructure.Blog.Friend.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Setting.Persistence;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Upload;

public sealed class ManagedImageQueryService(
	IAmazonS3 rustFsClient,
	IOptions<RustFsOptions> rustFsOptions,
	ISqlSugarDbContext dbContext) : IManagedImageQueryService {
	private static readonly HashSet<string> ImageExtensions = new(StringComparer.OrdinalIgnoreCase) {
		".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".svg", ".ico", ".avif"
	};

	public async Task<PagedResult<ManagedImageListItemDto>> GetAsync(ManagedImageListQuery query,
		CancellationToken cancellationToken = default){
		var pageNumber = Math.Max(query.PageNumber, 1);
		var pageSize = Math.Clamp(query.PageSize, 1, 200);
		var bucketName = string.IsNullOrWhiteSpace(query.BucketName)
			? rustFsOptions.Value.BucketName
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
		var orderedItems = ApplySort(items, query.SortOrder);
		var pageItems = orderedItems
			.Skip((pageNumber - 1) * pageSize)
			.Take(pageSize)
			.ToArray();

		return new PagedResult<ManagedImageListItemDto>(pageItems, pageNumber, pageSize, totalCount);
	}

	private async Task<List<ManagedImageObject>> GetImageObjectsAsync(string bucketName, CancellationToken cancellationToken){
		var result = new List<ManagedImageObject>();
		string? continuationToken = null;
		do {
			var response = await rustFsClient.ListObjectsV2Async(new ListObjectsV2Request {
				BucketName = bucketName,
				ContinuationToken = continuationToken
			}, cancellationToken);

			foreach (var item in response.S3Objects) {
				if (item.Key.EndsWith("/", StringComparison.Ordinal) || !IsImageObject(item.Key)) continue;

				result.Add(new ManagedImageObject(item.Key, item.Size, item.LastModified));
			}

			continuationToken = response.IsTruncated ? response.NextContinuationToken : null;
		} while (!string.IsNullOrWhiteSpace(continuationToken));

		return result.OrderByDescending(item => item.LastModified ?? DateTime.MinValue).ToList();
	}

	private async Task<IReadOnlyCollection<ManagedImageArticleReferenceDto>> GetReferencedArticlesAsync(string imageUrl){
		var references = new Dictionary<string, ManagedImageArticleReferenceDto>();

		var coverArticles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(article => article.Cover == imageUrl)
			.Select(article => new { article.Id, article.Title })
			.ToListAsync();
		foreach (var article in coverArticles) AddReference(references, $"article-cover:{article.Id}", article.Id, $"文章封面：{article.Title}");

		var columnCoverArticles = await dbContext.Client.Queryable<ColumnDataModel>()
			.Where(column => column.Cover == imageUrl)
			.Select(column => new { column.Id, column.Title })
			.ToListAsync();
		foreach (var column in columnCoverArticles) {
			var columnUrl = await BuildColumnDetailUrlAsync(column.Id);
			AddReference(references, $"column-cover:{column.Id}", (-1000 - column.Id).ToString(), $"专栏封面：{column.Title}", columnUrl);
		}

		var contentArticles = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.InnerJoin<ArticleDataModel>((content, article) => content.ArticleId == article.Id)
			.Where(content => content.Content.Contains(imageUrl))
			.Select((content, article) => new { article.Id, article.Title })
			.ToListAsync();
		foreach (var article in contentArticles) AddReference(references, $"article-content:{article.Id}", article.Id, $"文章内容：{article.Title}");

		var draftCoverArticles = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(draft => draft.ArticleId != null && draft.Cover == imageUrl)
			.Select(draft => new { ArticleId = draft.ArticleId!.Value, draft.Title })
			.ToListAsync();
		foreach (var article in draftCoverArticles) AddReference(references, $"draft-cover:{article.ArticleId}", article.ArticleId, $"文章封面（草稿）：{article.Title}");

		var draftContentArticles = await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.InnerJoin<ArticleDraftDataModel>((content, draft) => content.DraftId == draft.Id)
			.Where((content, draft) => draft.ArticleId != null && content.Content.Contains(imageUrl))
			.Select((content, draft) => new { ArticleId = draft.ArticleId!.Value, draft.Title })
			.ToListAsync();
		foreach (var article in draftContentArticles) AddReference(references, $"draft-content:{article.ArticleId}", article.ArticleId, $"文章内容（草稿）：{article.Title}");

		var setting = await dbContext.Client.Queryable<BlogSettingDataModel>()
			.Select(x => new { x.Name, x.Logo, x.Avatar })
			.SingleAsync();
		if (setting is not null) {
			if (setting.Logo == imageUrl) {
				AddReference(references, "blog-logo", "-1", $"博客 LOGO：{setting.Name}", "/blog/admin/blog/settings");
			}

			if (setting.Avatar == imageUrl) {
				AddReference(references, "blog-avatar", "-2", $"作者头像：{setting.Name}", "/blog/admin/blog/settings");
			}
		}

		var friendAvatars = await dbContext.Client.Queryable<FriendDataModel>()
			.Where(x => x.Avatar == imageUrl)
			.Select(x => new { x.Id, x.Name })
			.ToListAsync();
		foreach (var friend in friendAvatars) {
			AddReference(references, $"friend-avatar:{friend.Id}", (-2000 - friend.Id).ToString(), $"友链头像：{friend.Name}", "/blog/admin/friend");
		}

		return references.Values.ToArray();
	}

	private async Task<string> BuildColumnDetailUrlAsync(long columnId){
		var firstArticleId = await dbContext.Client.Queryable<ColumnCatalogDataModel>()
			.Where(catalog => catalog.ColumnId == columnId && catalog.Level == 2 && catalog.ArticleId != null && catalog.ArticleId > 0 && catalog.IsDeleted == 0)
			.OrderBy(catalog => catalog.Sort)
			.Select(catalog => catalog.ArticleId)
			.FirstAsync();

		return firstArticleId is > 0
			? $"/blog/surfer/column/{columnId}?articleId={firstArticleId}"
			: $"/blog/surfer/column/{columnId}";
	}

	private static void AddReference(IDictionary<string, ManagedImageArticleReferenceDto> references, string referenceKey,
		long articleId, string title, string? url = null){
		AddReference(references, referenceKey, articleId.ToString(), title, url);
	}

	private static void AddReference(IDictionary<string, ManagedImageArticleReferenceDto> references, string referenceKey,
		string articleId, string title, string? url = null){
		if (references.ContainsKey(referenceKey)) return;

		references[referenceKey] = new ManagedImageArticleReferenceDto(
			articleId,
			string.IsNullOrWhiteSpace(title) ? $"文章 {articleId}" : title,
			url ?? $"/blog/surfer/article/{articleId}");
	}

	private static IReadOnlyCollection<ManagedImageListItemDto> ApplySort(IReadOnlyCollection<ManagedImageListItemDto> items, string? sortOrder){
		return (sortOrder ?? "lastModifiedDesc") switch {
			"lastModifiedAsc" => items.OrderBy(item => item.LastModified ?? DateTime.MinValue).ToArray(),
			"nameAsc" => items.OrderBy(item => item.FileName, StringComparer.OrdinalIgnoreCase).ToArray(),
			"nameDesc" => items.OrderByDescending(item => item.FileName, StringComparer.OrdinalIgnoreCase).ToArray(),
			_ => items.OrderByDescending(item => item.LastModified ?? DateTime.MinValue).ToArray()
		};
	}

	private string BuildObjectUrl(string bucketName, string objectName){
		var publicEndpoint = string.IsNullOrWhiteSpace(rustFsOptions.Value.PublicEndpoint)
			? rustFsOptions.Value.Endpoint
			: rustFsOptions.Value.PublicEndpoint;

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
