namespace Mint.Blog.Model.Dtos.Blog.Gallery;

public sealed record GalleryCategoryPageQuery(int PageNumber = 1, int PageSize = 20, string? Keyword = null);
public sealed record GalleryImagePageQuery(
	int PageNumber = 1,
	int PageSize = 20,
	string? Keyword = null,
	long? CategoryId = null,
	bool EnabledOnly = false,
	string? Resolution = null,
	string? Ratio = null,
	string? SortOrder = null);

public sealed record SaveGalleryCategoryCommand(string Name, string? Description, int Sort, bool Enabled);
public sealed record SaveGalleryImageCommand(
	string Name,
	long CategoryId,
	string? Resolution,
	string? Ratio,
	DateOnly? Time,
	string Url,
	string SourceType,
	string? BucketName,
	string? ObjectName,
	string? FileName,
	int Size,
	int Sort,
	bool Enabled);
