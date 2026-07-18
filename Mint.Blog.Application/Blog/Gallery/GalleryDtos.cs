using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;

namespace Mint.Blog.Application.Blog.Gallery;

public sealed record GalleryCategoryDto(
	long Id,
	string Name,
	string Description,
	int Sort,
	bool Enabled,
	DateTimeOffset CreatedAt,
	DateTimeOffset UpdatedAt);

public sealed record GalleryImageDto(
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
	int Sort,
	bool Enabled,
	DateTimeOffset CreatedAt,
	DateTimeOffset UpdatedAt);

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
	int Sort,
	bool Enabled);

public interface IGalleryQueryService {
	Task<PagedResult<GalleryCategoryDto>> GetCategoriesAsync(GalleryCategoryPageQuery query, CancellationToken cancellationToken = default);
	Task<IReadOnlyCollection<GalleryCategoryDto>> GetCategoryOptionsAsync(CancellationToken cancellationToken = default);
	Task<PagedResult<GalleryImageDto>> GetImagesAsync(GalleryImagePageQuery query, CancellationToken cancellationToken = default);
}

public interface IGalleryCommandService {
	Task<long> CreateCategoryAsync(SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default);
	Task UpdateCategoryAsync(long id, SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default);
	Task DeleteCategoryAsync(long id, CancellationToken cancellationToken = default);
	Task<long> CreateImageAsync(SaveGalleryImageCommand command, CancellationToken cancellationToken = default);
	Task UpdateImageAsync(long id, SaveGalleryImageCommand command, CancellationToken cancellationToken = default);
	Task DeleteImageAsync(long id, CancellationToken cancellationToken = default);
}
