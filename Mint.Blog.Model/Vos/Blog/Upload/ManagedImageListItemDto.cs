namespace Mint.Blog.Model.Vos.Blog.Upload;

public sealed record ManagedImageArticleReferenceDto(string ArticleId, string ArticleTitle, string ArticleUrl);
public sealed record ManagedImageListItemDto(string BucketName, string ObjectName, string FileName, string Url, long Size, DateTime? LastModified, IReadOnlyCollection<ManagedImageArticleReferenceDto> ReferencedArticles);
public sealed class ImageReferenceRow {
    public long Id { get; set; }
    public string Title { get; set; } = string.Empty;
}
public sealed record ImageReferencesData(
    IReadOnlyCollection<ImageReferenceRow> ArticleCovers,
    IReadOnlyCollection<ImageReferenceRow> ColumnCovers,
    IReadOnlyCollection<ImageReferenceRow> ArticleContents,
    IReadOnlyCollection<ImageReferenceRow> DraftCovers,
    IReadOnlyCollection<ImageReferenceRow> DraftContents,
    string? SettingName, string? SettingLogo, string? SettingAvatar,
    IReadOnlyCollection<ImageReferenceRow> GalleryImages,
    IReadOnlyCollection<ImageReferenceRow> FriendAvatars);
