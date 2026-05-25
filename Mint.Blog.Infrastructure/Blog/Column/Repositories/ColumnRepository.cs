using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnCatalog;
using Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnPageList;
using Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnArticlePreNext;
using Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnCatalog;
using Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnList;
using Mint.Blog.Domain.Blog.Column.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Column.Persistence;
using ColumnEntity = Mint.Blog.Domain.Blog.Column.Entities.Column;

namespace Mint.Blog.Infrastructure.Blog.Column.Repositories;

public sealed class ColumnRepository(ISqlSugarDbContext dbContext)
	: IColumnRepository,
		IGetAdminColumnPageListQueryService,
		IGetAdminColumnCatalogQueryService,
		IGetBlogColumnListQueryService,
		IGetBlogColumnCatalogQueryService,
		IGetBlogColumnArticlePreNextQueryService {
	public async Task<IReadOnlyCollection<AdminColumnCatalogItemDto>> GetAsync(long columnId,
		CancellationToken cancellationToken = default){
		var catalogs = await dbContext.Client.Queryable<ColumnCatalogDataModel>()
			.Where(x => x.ColumnId == columnId && x.IsDeleted == 0)
			.OrderBy(x => x.Sort)
			.OrderBy(x => x.Id)
			.ToListAsync();

		return BuildAdminCatalogTree(catalogs);
	}

	public async Task<PagedResult<AdminColumnPageItemDto>> GetAsync(GetAdminColumnPageListQuery query,
		CancellationToken cancellationToken = default){
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (pageNumber - 1) * pageSize;

		var columnQuery = dbContext.Client.Queryable<ColumnDataModel>();

		if (!string.IsNullOrWhiteSpace(query.Title)) {
			var keyword = query.Title.Trim();
			columnQuery = columnQuery.Where(x => x.Title.Contains(keyword));
		}

		if (query.StartDate.HasValue) {
			var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			columnQuery = columnQuery.Where(x => x.CreatedAt >= start);
		}

		if (query.EndDate.HasValue) {
			var endExclusive = query.EndDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			columnQuery = columnQuery.Where(x => x.CreatedAt < endExclusive);
		}

		var totalCount = await columnQuery.CountAsync();
		var items = await columnQuery
			.OrderByDescending(x => x.Weight)
			.OrderByDescending(x => x.CreatedAt)
			.Skip(skip)
			.Take(pageSize)
			.ToListAsync();

		if (items.Count == 0) {
			return new PagedResult<AdminColumnPageItemDto>([], pageNumber, pageSize, totalCount);
		}

		var columnIds = items.Select(x => x.Id).ToArray();
		var catalogs = await dbContext.Client.Queryable<ColumnCatalogDataModel>()
			.Where(x => columnIds.Contains(x.ColumnId) && x.IsDeleted == 0)
			.ToListAsync();
		var validArticleIds = await GetValidArticleIdsAsync(catalogs, cancellationToken);

		return new PagedResult<AdminColumnPageItemDto>(
			items.Select(item => MapToAdminPageItem(item, validArticleIds, catalogs)).ToArray(),
			pageNumber,
			pageSize,
			totalCount);
	}

	public async Task<BlogColumnArticlePreNextDto> GetAsync(BlogColumnArticlePreNextQuery query,
		CancellationToken cancellationToken = default){
		var catalogs = await dbContext.Client.Queryable<ColumnCatalogDataModel>()
			.Where(x => x.ColumnId == query.ColumnId && x.ArticleId > 0 && x.IsDeleted == 0)
			.OrderBy(x => x.Sort)
			.OrderBy(x => x.Id)
			.ToListAsync();

		if (catalogs.Count == 0) return new BlogColumnArticlePreNextDto(null, null);

		var validArticleIds = await GetValidArticleIdsAsync(catalogs, cancellationToken);
		var articleCatalogs = catalogs
			.Where(x => x.ArticleId.HasValue && validArticleIds.Contains(x.ArticleId.Value))
			.OrderBy(x => x.Sort)
			.ThenBy(x => x.Id)
			.ToArray();

		var currentIndex = Array.FindIndex(articleCatalogs, x => x.ArticleId == query.ArticleId);
		if (currentIndex < 0) return new BlogColumnArticlePreNextDto(null, null);

		var previous = currentIndex > 0 ? articleCatalogs[currentIndex - 1] : null;
		var next = currentIndex < articleCatalogs.Length - 1 ? articleCatalogs[currentIndex + 1] : null;

		return new BlogColumnArticlePreNextDto(
			previous is null ? null : new BlogColumnArticleLinkDto(previous.ArticleId ?? 0, previous.Title),
			next is null ? null : new BlogColumnArticleLinkDto(next.ArticleId ?? 0, next.Title));
	}

	public async Task<IReadOnlyCollection<BlogColumnCatalogItemDto>> GetAsync(BlogColumnCatalogQuery query,
		CancellationToken cancellationToken = default){
		var catalogs = await dbContext.Client.Queryable<ColumnCatalogDataModel>()
			.Where(x => x.ColumnId == query.ColumnId && x.IsDeleted == 0)
			.OrderBy(x => x.Sort)
			.OrderBy(x => x.Id)
			.ToListAsync();

		var validArticleIds = await GetValidArticleIdsAsync(catalogs, cancellationToken);
		return BuildBlogCatalogTree(catalogs, validArticleIds);
	}

	public async Task<IReadOnlyCollection<BlogColumnListItemDto>> GetAsync(CancellationToken cancellationToken = default){
		var columns = await dbContext.Client.Queryable<ColumnDataModel>()
			.Where(x => x.IsPublish != 0 && x.IsDeleted == 0)
			.OrderByDescending(x => x.Weight)
			.OrderByDescending(x => x.CreatedAt)
			.ToListAsync();

		if (columns.Count == 0) return [];

		var columnIds = columns.Select(x => x.Id).ToArray();
		var catalogs = await dbContext.Client.Queryable<ColumnCatalogDataModel>()
			.Where(x => columnIds.Contains(x.ColumnId) && x.IsDeleted == 0)
			.ToListAsync();
		var validArticleIds = await GetValidArticleIdsAsync(catalogs, cancellationToken);

		return columns.Select(column => {
			var columnCatalogs = catalogs.Where(x => x.ColumnId == column.Id).ToList();
			var firstArticleId = columnCatalogs
				.Where(x => x.Level == 2 && x.ArticleId.HasValue && x.ArticleId > 0 && validArticleIds.Contains(x.ArticleId.Value))
				.OrderBy(x => x.Id)
				.Select(x => (long?)x.ArticleId)
				.FirstOrDefault();

			var articleTotal = columnCatalogs.Count(x => x.ArticleId.HasValue && x.ArticleId > 0 && validArticleIds.Contains(x.ArticleId.Value));

			return new BlogColumnListItemDto(
				column.Id,
				column.Cover,
				column.Title,
				articleTotal,
				column.Summary,
				column.Sort,
				column.Weight,
				column.Weight > 0,
				firstArticleId);
		}).ToArray();
	}

	public async Task<ColumnEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<ColumnDataModel>()
			.Where(x => x.Id == id)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task<long> AddAsync(ColumnEntity column, CancellationToken cancellationToken = default){
		var data = new ColumnDataModel {
			Title = column.Title,
			Summary = column.Summary,
			Cover = column.Cover,
			IsDeleted = column.IsDeleted ? (short)1 : (short)0,
			Weight = column.Weight,
			IsPublish = column.IsPublish ? (short)1 : (short)0,
			Sort = column.Sort,
			CreatedAt = column.CreatedAt,
			UpdatedAt = column.UpdatedAt
		};

		return await dbContext.Client.Insertable(data).ExecuteReturnSnowflakeIdAsync();
	}

	public Task UpdateAsync(ColumnEntity column, CancellationToken cancellationToken = default){
		var data = new ColumnDataModel {
			Id = column.Id,
			Title = column.Title,
			Summary = column.Summary,
			Cover = column.Cover,
			IsDeleted = column.IsDeleted ? (short)1 : (short)0,
			Weight = column.Weight,
			IsPublish = column.IsPublish ? (short)1 : (short)0,
			Sort = column.Sort,
			CreatedAt = column.CreatedAt,
			UpdatedAt = column.UpdatedAt
		};

		return dbContext.Client.Updateable(data).ExecuteCommandAsync();
	}

	public Task DeleteAsync(long id, CancellationToken cancellationToken = default){
		return dbContext.Client.Deleteable<ColumnDataModel>()
			.Where(x => x.Id == id)
			.ExecuteCommandAsync();
	}

	public Task<bool> ExistsByTitleAsync(string title, long? excludeId = null,
		CancellationToken cancellationToken = default){
		var query = dbContext.Client.Queryable<ColumnDataModel>()
			.Where(x => x.Title == title && x.IsDeleted == 0);

		if (excludeId.HasValue) query = query.Where(x => x.Id != excludeId.Value);

		return query.AnyAsync();
	}

	public async Task<int> GetMaxWeightAsync(CancellationToken cancellationToken = default){
		var column = await dbContext.Client.Queryable<ColumnDataModel>()
			.OrderByDescending(x => x.Weight)
			.FirstAsync();

		return column?.Weight ?? 0;
	}

	public async Task UpdateCatalogAsync(long columnId, IReadOnlyCollection<ColumnCatalogUpsertModel> catalogs,
		CancellationToken cancellationToken = default){
		await dbContext.Client.Deleteable<ColumnCatalogDataModel>()
			.Where(x => x.ColumnId == columnId)
			.ExecuteCommandAsync();

		if (catalogs.Count == 0) return;

		var nextId = await GetNextCatalogIdAsync();
		var parentMap = new Dictionary<int, long>();
		var parentItems = catalogs.Where(x => x.Level == 1).OrderBy(x => x.Sort).ToArray();

		for (var i = 0; i < parentItems.Length; i++) {
			var parent = parentItems[i];
			var parentId = nextId++;

			await dbContext.Client.Insertable(new ColumnCatalogDataModel {
				Id = parentId,
				ColumnId = columnId,
				ArticleId = null,
				Title = parent.Title,
				Level = 1,
				ParentId = 0,
				Sort = parent.Sort,
				CreatedAt = DateTimeOffset.UtcNow,
				UpdatedAt = DateTimeOffset.UtcNow,
				IsDeleted = parent.IsDeleted ? (short)1 : (short)0
			}).ExecuteCommandAsync();

			parentMap[i + 1] = parentId;
		}

		var childItems = catalogs.Where(x => x.Level == 2).OrderBy(x => x.ParentId).ThenBy(x => x.Sort).ToArray();
		if (childItems.Length == 0) return;

		var childRows = childItems.Select(child => new ColumnCatalogDataModel {
			Id = nextId++,
			ColumnId = columnId,
			ArticleId = child.ArticleId,
			Title = child.Title,
			Level = 2,
			ParentId = parentMap.GetValueOrDefault((int)child.ParentId, 0),
			Sort = child.Sort,
			CreatedAt = DateTimeOffset.UtcNow,
			UpdatedAt = DateTimeOffset.UtcNow,
			IsDeleted = child.IsDeleted ? (short)1 : (short)0
		}).ToArray();

		await dbContext.Client.Insertable(childRows).ExecuteCommandAsync();
	}

	private async Task<long> GetNextCatalogIdAsync(){
		var maxId = await dbContext.Client.Queryable<ColumnCatalogDataModel>()
			.OrderByDescending(x => x.Id)
			.Select(x => x.Id)
			.FirstAsync();

		return maxId <= 0 ? 1 : maxId + 1;
	}

	private static ColumnEntity MapToDomain(ColumnDataModel data){
		return ColumnEntity.Rehydrate(
			data.Id,
			data.Title,
			data.Summary,
			data.Cover,
			data.IsDeleted != 0,
			data.Weight,
			data.IsPublish != 0,
			data.Sort,
			data.CreatedAt,
			data.UpdatedAt);
	}

	private static AdminColumnPageItemDto MapToAdminPageItem(ColumnDataModel column, IReadOnlySet<long> validArticleIds,
		IReadOnlyCollection<ColumnCatalogDataModel> catalogs){
		var articlesTotal = catalogs.Count(x =>
			x.ColumnId == column.Id && x.ArticleId.HasValue && x.ArticleId > 0 && validArticleIds.Contains(x.ArticleId.Value));

		return new AdminColumnPageItemDto(
			column.Id,
			column.Title,
			column.Cover,
			column.Summary,
			column.Sort,
			column.Weight,
			column.CreatedAt,
			column.Weight > 0,
			column.IsPublish != 0,
			articlesTotal,
			column.IsDeleted);
	}

	private static IReadOnlyCollection<AdminColumnCatalogItemDto> BuildAdminCatalogTree(
		IReadOnlyCollection<ColumnCatalogDataModel> catalogs){
		var level1 = catalogs.Where(x => x.Level == 1).OrderBy(x => x.Sort).ThenBy(x => x.Id).ToList();

		return level1.Select(parent => {
			var children = catalogs
				.Where(x => x.ParentId == parent.Id && x.Level == 2)
				.OrderBy(x => x.Sort)
				.ThenBy(x => x.Id)
				.Select(child => new AdminColumnCatalogItemDto(child.Id, child.ArticleId ?? 0, child.Title, child.Sort,
				child.Level, child.IsDeleted != 0, false, []))
			.ToArray();

		return new AdminColumnCatalogItemDto(parent.Id, parent.ArticleId ?? 0, parent.Title, parent.Sort, parent.Level,
			parent.IsDeleted != 0, false, children);
		}).ToArray();
	}

	private async Task<HashSet<long>> GetValidArticleIdsAsync(IReadOnlyCollection<ColumnCatalogDataModel> catalogs,
		CancellationToken cancellationToken){
		var articleIds = catalogs
			.Where(x => x.Level == 2 && x.ArticleId.HasValue && x.ArticleId > 0)
			.Select(x => x.ArticleId!.Value)
			.Distinct()
			.ToArray();

		if (articleIds.Length == 0) return [];

		var validArticleIds = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => articleIds.Contains(x.Id) && x.IsDeleted == 0)
			.Select(x => x.Id)
			.ToListAsync();

		return validArticleIds.ToHashSet();
	}

	public async Task ValidateArticleIdsAsync(IReadOnlyCollection<long> articleIds, CancellationToken cancellationToken = default){
		if (articleIds.Count == 0) return;

		var distinctIds = articleIds.Distinct().ToArray();
		var existingIds = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => distinctIds.Contains(x.Id) && x.IsDeleted == 0)
			.Select(x => x.Id)
			.ToListAsync();

		var existingSet = existingIds.ToHashSet();
		var invalidIds = distinctIds.Where(id => !existingSet.Contains(id)).ToArray();

		Guard.Against(invalidIds.Length > 0, ErrorCodes.ArticleNotFound,
			$"以下文章 ID 不存在或已删除：{string.Join(", ", invalidIds)}");
	}

	private static IReadOnlyCollection<BlogColumnCatalogItemDto> BuildBlogCatalogTree(
		IReadOnlyCollection<ColumnCatalogDataModel> catalogs,
		IReadOnlySet<long> validArticleIds){
		var level1 = catalogs
			.Where(x => x.Level == 1)
			.OrderBy(x => x.Sort)
			.ThenBy(x => x.Id)
			.ToList();

		return level1.Select(parent => {
			var children = catalogs
				.Where(x => x.ParentId == parent.Id && x.Level == 2 && x.ArticleId.HasValue && x.ArticleId > 0 && validArticleIds.Contains(x.ArticleId.Value))
				.OrderBy(x => x.Sort)
				.ThenBy(x => x.Id)
				.Select(child => new BlogColumnCatalogItemDto(child.Id, child.ArticleId ?? 0, child.Title, child.Level, []))
				.ToArray();

			return new BlogColumnCatalogItemDto(parent.Id, parent.ArticleId ?? 0, parent.Title, parent.Level, children);
		}).ToArray();
	}
}