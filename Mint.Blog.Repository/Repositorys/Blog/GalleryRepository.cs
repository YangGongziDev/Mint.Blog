using Mint.Blog.Model.Dtos.Blog.Gallery;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Gallery;
using Mint.Blog.Model.Entitys.Blog.Gallery;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class GalleryRepository(ISqlSugarDbContext dbContext) : IGalleryRepository {
	public async Task<PagedResult<GalleryCategoryVo>> GetCategoriesAsync(GalleryCategoryPageQuery query,
		CancellationToken cancellationToken = default){
		EnsureTables();
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 20 : query.PageSize;
		var dbQuery = dbContext.Client.Queryable<GalleryCategoryDataModel>();
		if (!string.IsNullOrWhiteSpace(query.Keyword)) {
			var keyword = query.Keyword.Trim();
			dbQuery = dbQuery.Where(x => x.Name.Contains(keyword) || x.Description.Contains(keyword));
		}
		var total = await dbQuery.CountAsync(cancellationToken);
		var items = await dbQuery.OrderByDescending(x => x.Sort).OrderByDescending(x => x.CreatedAt)
			.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken);
		return new PagedResult<GalleryCategoryVo>(items.Select(MapCategory).ToArray(), pageNumber, pageSize, total);
	}

	public async Task<IReadOnlyCollection<GalleryCategoryVo>> GetCategoryOptionsAsync(CancellationToken cancellationToken = default){
		EnsureTables();
		var items = await dbContext.Client.Queryable<GalleryCategoryDataModel>().Where(x => x.Enabled)
			.OrderByDescending(x => x.Sort).OrderByDescending(x => x.CreatedAt).ToListAsync(cancellationToken);
		return items.Select(MapCategory).ToArray();
	}

	public async Task<PagedResult<GalleryImageVo>> GetImagesAsync(GalleryImagePageQuery query, CancellationToken cancellationToken = default){
		EnsureTables();
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 20 : query.PageSize;
		var imageQuery = dbContext.Client.Queryable<GalleryImageDataModel>();
		if (!string.IsNullOrWhiteSpace(query.Keyword)) {
			var keyword = query.Keyword.Trim();
			var matchedCategoryIds = await dbContext.Client.Queryable<GalleryCategoryDataModel>()
				.Where(x => x.Name.Contains(keyword)).Select(x => x.Id).ToListAsync(cancellationToken);
			imageQuery = imageQuery.Where(x => x.Name.Contains(keyword) || x.Resolution.Contains(keyword) || x.Ratio.Contains(keyword) || matchedCategoryIds.Contains(x.CategoryId));
		}
		if (query.CategoryId.HasValue) imageQuery = imageQuery.Where(x => x.CategoryId == query.CategoryId.Value);
		if (!string.IsNullOrWhiteSpace(query.Resolution)) imageQuery = imageQuery.Where(x => x.Resolution == query.Resolution.Trim());
		if (!string.IsNullOrWhiteSpace(query.Ratio)) imageQuery = imageQuery.Where(x => x.Ratio == query.Ratio.Trim());
		if (query.EnabledOnly) {
			var enabledCategoryIds = await dbContext.Client.Queryable<GalleryCategoryDataModel>().Where(x => x.Enabled)
				.Select(x => x.Id).ToListAsync(cancellationToken);
			imageQuery = imageQuery.Where(x => x.Enabled && enabledCategoryIds.Contains(x.CategoryId));
		}
		var total = await imageQuery.CountAsync(cancellationToken);
		var orderedQuery = query.SortOrder switch {
			"nameAsc" => imageQuery.OrderBy(x => x.Name),
			"nameDesc" => imageQuery.OrderByDescending(x => x.Name),
			"timeAsc" => imageQuery.OrderBy(x => x.Time),
			_ => imageQuery.OrderByDescending(x => x.Time).OrderByDescending(x => x.CreatedAt)
		};
		var images = await orderedQuery.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken);
		var categoryIds = images.Select(x => x.CategoryId).Distinct().ToArray();
		var categories = categoryIds.Length == 0 ? [] : await dbContext.Client.Queryable<GalleryCategoryDataModel>()
			.Where(x => categoryIds.Contains(x.Id)).ToListAsync(cancellationToken);
		var categoryMap = categories.ToDictionary(x => x.Id, x => x.Name);
		var items = images.Select(x => MapImage(x, categoryMap.TryGetValue(x.CategoryId, out var categoryName) ? categoryName : string.Empty)).ToArray();
		return new PagedResult<GalleryImageVo>(items, pageNumber, pageSize, total);
	}

	public async Task<long> CreateCategoryAsync(SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default){
		var now = DateTimeOffset.UtcNow;
		return await dbContext.Client.Insertable(new GalleryCategoryDataModel {
			Name = command.Name.Trim(), Description = command.Description?.Trim() ?? string.Empty,
			Sort = command.Sort, Enabled = command.Enabled, CreatedAt = now, UpdatedAt = now
		}).ExecuteReturnIdentityAsync(cancellationToken);
	}

	public Task<int> UpdateCategoryAsync(long id, SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default){
		var description = command.Description?.Trim() ?? string.Empty;
		return dbContext.Client.Updateable<GalleryCategoryDataModel>().SetColumns(x => new GalleryCategoryDataModel {
			Name = command.Name.Trim(), Description = description, Sort = command.Sort,
			Enabled = command.Enabled, UpdatedAt = DateTimeOffset.UtcNow
		}).Where(x => x.Id == id).ExecuteCommandAsync(cancellationToken);
	}

	public Task<bool> CategoryIsUsedAsync(long id, CancellationToken cancellationToken = default) =>
		dbContext.Client.Queryable<GalleryImageDataModel>().AnyAsync(x => x.CategoryId == id, cancellationToken);
	public Task<bool> CategoryExistsAsync(long id, CancellationToken cancellationToken = default) =>
		dbContext.Client.Queryable<GalleryCategoryDataModel>().AnyAsync(x => x.Id == id, cancellationToken);
	public async Task DeleteCategoryAsync(long id, CancellationToken cancellationToken = default) =>
		await dbContext.Client.Deleteable<GalleryCategoryDataModel>().Where(x => x.Id == id).ExecuteCommandAsync(cancellationToken);

	public async Task<long> CreateImageAsync(SaveGalleryImageCommand command, CancellationToken cancellationToken = default){
		var now = DateTimeOffset.UtcNow;
		return await dbContext.Client.Insertable(new GalleryImageDataModel {
			Name = command.Name.Trim(), CategoryId = command.CategoryId,
			Resolution = command.Resolution?.Trim() ?? string.Empty, Ratio = command.Ratio?.Trim() ?? string.Empty,
			Time = command.Time?.ToDateTime(TimeOnly.MinValue), Url = command.Url.Trim(), SourceType = command.SourceType,
			BucketName = command.BucketName?.Trim() ?? string.Empty, ObjectName = command.ObjectName?.Trim() ?? string.Empty,
			FileName = command.FileName?.Trim() ?? string.Empty, Size = command.Size, Sort = command.Sort,
			Enabled = command.Enabled, CreatedAt = now, UpdatedAt = now
		}).ExecuteReturnIdentityAsync(cancellationToken);
	}

	public Task<int> UpdateImageAsync(long id, SaveGalleryImageCommand command, CancellationToken cancellationToken = default){
		var resolution = command.Resolution?.Trim() ?? string.Empty;
		var ratio = command.Ratio?.Trim() ?? string.Empty;
		DateTime? time = command.Time.HasValue ? command.Time.Value.ToDateTime(TimeOnly.MinValue) : null;
		var sourceType = command.SourceType;
		var bucketName = command.BucketName?.Trim() ?? string.Empty;
		var objectName = command.ObjectName?.Trim() ?? string.Empty;
		var fileName = command.FileName?.Trim() ?? string.Empty;
		return dbContext.Client.Updateable<GalleryImageDataModel>().SetColumns(x => new GalleryImageDataModel {
			Name = command.Name.Trim(), CategoryId = command.CategoryId, Resolution = resolution, Ratio = ratio,
			Time = time, Url = command.Url.Trim(), SourceType = sourceType, BucketName = bucketName,
			ObjectName = objectName, FileName = fileName, Size = command.Size, Sort = command.Sort,
			Enabled = command.Enabled, UpdatedAt = DateTimeOffset.UtcNow
		}).Where(x => x.Id == id).ExecuteCommandAsync(cancellationToken);
	}

	public async Task DeleteImageAsync(long id, CancellationToken cancellationToken = default) =>
		await dbContext.Client.Deleteable<GalleryImageDataModel>().Where(x => x.Id == id).ExecuteCommandAsync(cancellationToken);
	public void EnsureTables() => dbContext.Client.CodeFirst.InitTables<GalleryCategoryDataModel, GalleryImageDataModel>();
	private static GalleryCategoryVo MapCategory(GalleryCategoryDataModel data) =>
		new(data.Id, data.Name, data.Description, data.Sort, data.Enabled, data.CreatedAt, data.UpdatedAt);
	private static GalleryImageVo MapImage(GalleryImageDataModel data, string categoryName) =>
		new(data.Id, data.Name, data.CategoryId, categoryName, data.Resolution, data.Ratio,
			data.Time.HasValue ? DateOnly.FromDateTime(data.Time.Value) : null, data.Url, data.SourceType,
			data.BucketName, data.ObjectName, data.FileName, data.Size, data.Sort, data.Enabled, data.CreatedAt, data.UpdatedAt);
}
