using System.Text.RegularExpressions;
using Mint.Blog.Common.Storage;
using Mint.Blog.Model.Dtos.Blog.Upload;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Upload;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class ManagedImageService(IObjectStorageQueryService storage, IObjectStorageBucketService buckets, IImageRepository repository) : IManagedImageService {
    private static readonly HashSet<string> ImageExtensions = new(StringComparer.OrdinalIgnoreCase) {
        ".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".svg", ".ico", ".avif"
    };
    public Task<IReadOnlyCollection<ObjectStorageBucketDto>> GetBucketsAsync(CancellationToken cancellationToken = default) => buckets.GetBucketsAsync(cancellationToken);
    public Task CreateBucketAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default) => buckets.CreateBucketAsync(bucketName, isPublic, cancellationToken);
    public Task SetBucketPublicAsync(string bucketName, bool isPublic, CancellationToken cancellationToken = default) => buckets.SetBucketPublicAsync(bucketName, isPublic, cancellationToken);
    public Task DeleteBucketAsync(string bucketName, CancellationToken cancellationToken = default) => buckets.DeleteBucketAsync(bucketName, cancellationToken);
    public async Task<PagedResult<ManagedImageListItemDto>> GetAsync(ManagedImageListQuery query, CancellationToken cancellationToken = default) {
        var pageNumber = Math.Max(query.PageNumber, 1);
        var pageSize = Math.Clamp(query.PageSize, 1, 200);
        var bucketName = storage.ResolveBucketName(query.BucketName);
        var objects = (await storage.ListAsync(bucketName, cancellationToken))
            .Where(x => !x.ObjectName.EndsWith("/", StringComparison.Ordinal) && IsImageObject(x.ObjectName))
            .OrderByDescending(x => x.LastModified ?? DateTime.MinValue).ToList();
        if (!string.IsNullOrWhiteSpace(query.FileName)) objects = objects.Where(x => x.ObjectName.Contains(query.FileName.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
        var items = new List<ManagedImageListItemDto>();
        foreach (var item in objects) {
            var url = storage.BuildObjectUrl(bucketName, item.ObjectName);
            var references = await GetReferencesAsync(url, cancellationToken);
            if (query.Used.HasValue && query.Used.Value != references.Count > 0) continue;
            items.Add(new(bucketName, item.ObjectName, Path.GetFileName(item.ObjectName), url, item.Size, item.LastModified, references));
        }
        var ordered = (query.SortOrder ?? "lastModifiedDesc") switch {
            "lastModifiedAsc" => items.OrderBy(x => x.LastModified ?? DateTime.MinValue),
            "nameAsc" => items.OrderBy(x => x.FileName, StringComparer.OrdinalIgnoreCase),
            "nameDesc" => items.OrderByDescending(x => x.FileName, StringComparer.OrdinalIgnoreCase),
            _ => items.OrderByDescending(x => x.LastModified ?? DateTime.MinValue)
        };
        return new(ordered.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToArray(), pageNumber, pageSize, items.Count);
    }
    private async Task<IReadOnlyCollection<ManagedImageArticleReferenceDto>> GetReferencesAsync(string imageUrl, CancellationToken ct) {
        var rows = await repository.GetReferencesAsync(imageUrl, ct);
        var references = new Dictionary<string, ManagedImageArticleReferenceDto>();
        foreach (var row in rows.ArticleCovers) Add(references, $"article-cover:{row.Id}", row.Id.ToString(), $"文章封面：{row.Title}");
        foreach (var row in rows.ColumnCovers) {
            var firstId = await repository.GetFirstColumnArticleIdAsync(row.Id, ct);
            var url = firstId is > 0 ? $"/columns/{row.Id}?articleId={firstId}" : $"/columns/{row.Id}";
            Add(references, $"column-cover:{row.Id}", (-1000 - row.Id).ToString(), $"专栏封面：{row.Title}", url);
        }
        foreach (var row in rows.ArticleContents) Add(references, $"article-content:{row.Id}", row.Id.ToString(), $"文章内容：{row.Title}");
        foreach (var row in rows.DraftCovers) Add(references, $"draft-cover:{row.Id}", row.Id.ToString(), $"文章封面（草稿）：{row.Title}");
        foreach (var row in rows.DraftContents) Add(references, $"draft-content:{row.Id}", row.Id.ToString(), $"文章内容（草稿）：{row.Title}");
        if (rows.SettingLogo == imageUrl) Add(references, "blog-logo", "-1", $"博客 LOGO：{rows.SettingName}", "/blog/admin/blog/settings");
        if (rows.SettingAvatar == imageUrl) Add(references, "blog-avatar", "-2", $"作者头像：{rows.SettingName}", "/blog/admin/blog/settings");
        foreach (var row in rows.GalleryImages) Add(references, $"gallery-image:{row.Id}", $"gallery-image-{row.Id}", $"画廊图片：{row.Title}", "/blog/admin/gallery");
        foreach (var row in rows.FriendAvatars) Add(references, $"friend-avatar:{row.Id}", (-2000 - row.Id).ToString(), $"友链头像：{row.Title}", "/blog/admin/friend");
        return references.Values.ToArray();
    }
    private static void Add(IDictionary<string, ManagedImageArticleReferenceDto> references, string key, string id, string title, string? url = null) {
        if (references.ContainsKey(key)) return;
        references[key] = new(id, string.IsNullOrWhiteSpace(title) ? $"文章 {id}" : title, url ?? $"/articles/{id}");
    }
    private static bool IsImageObject(string name) => ImageExtensions.Contains(Path.GetExtension(name)) ||
        Regex.IsMatch(name, @"\.(jpg|jpeg|png|gif|webp|bmp|svg|ico|avif)(\?.*)?$", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
}
