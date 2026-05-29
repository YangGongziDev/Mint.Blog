namespace Mint.Blog.Application.Blog.Upload.Images;

public sealed record ManagedImageListQuery(
	int PageNumber = 1,
	int PageSize = 20,
	string? BucketName = null,
	string? FileName = null,
	bool? Used = null,
	string? SortOrder = null);
