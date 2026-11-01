namespace Mint.Blog.Model.Vos.Blog.Gallery;

public sealed record GalleryCategoryVo(
	long Id,
	string Name,
	string Description,
	int Sort,
	bool Enabled,
	DateTimeOffset CreatedAt,
	DateTimeOffset UpdatedAt);

public sealed record GalleryImageVo(
	long Id,
	string Name,
	long CategoryId,
	string CategoryName,
	string Resolution,
	string Ratio,
	DateOnly? Time,
	string Url,
	string SourceType,
	string BucketName,
	string ObjectName,
	string FileName,
	int Size,
	int Sort,
	bool Enabled,
	DateTimeOffset CreatedAt,
	DateTimeOffset UpdatedAt);
