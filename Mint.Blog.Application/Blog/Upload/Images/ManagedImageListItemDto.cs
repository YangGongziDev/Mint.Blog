namespace Mint.Blog.Application.Blog.Upload.Images;

public sealed record ManagedImageArticleReferenceDto(
	string ArticleId,
	string ArticleTitle,
	string ArticleUrl);

public sealed record ManagedImageListItemDto(
	string BucketName,
	string ObjectName,
	string FileName,
	string Url,
	long Size,
	DateTime? LastModified,
	IReadOnlyCollection<ManagedImageArticleReferenceDto> ReferencedArticles);
