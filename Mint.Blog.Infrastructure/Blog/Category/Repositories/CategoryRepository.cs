using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryPageList;
using Mint.Blog.Domain.Blog.Category.Repositories;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Category.Persistence;

namespace Mint.Blog.Infrastructure.Blog.Category.Repositories;

public sealed class CategoryRepository(ISqlSugarDbContext dbContext)
	: ICategoryRepository, IGetCategoryListQueryService, IGetCategoryPageListQueryService {
	public Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default){
		return ExistsAsync(id, false, cancellationToken);
	}

	public Task<bool> ExistsAsync(long id, bool includeDeleted, CancellationToken cancellationToken = default){
		var query = dbContext.Client.Queryable<CategoryDataModel>()
			.Where(x => x.Id == id);

		if (!includeDeleted) query = query.Where(x => x.IsDeleted == 0);

		return query.AnyAsync();
	}

	public async Task<long> AddAsync(string name, CancellationToken cancellationToken = default){
		var now = DateTimeOffset.UtcNow;
		var category = new CategoryDataModel {
			Name = name,
			CreatedAt = now,
			UpdatedAt = now,
			IsDeleted = 0,
			ArticlesTotal = 0,
			Sort = 0
		};

		return await dbContext.Client.Insertable(category).ExecuteReturnSnowflakeIdAsync();
	}

	public async Task UpdateAsync(long id, string name, CancellationToken cancellationToken = default){
		var category = await dbContext.Client.Queryable<CategoryDataModel>()
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.SingleAsync();

		if (category is null) return;

		category.Name = name;
		category.UpdatedAt = DateTimeOffset.UtcNow;
		await dbContext.Client.Updateable(category).ExecuteCommandAsync();
	}

	public Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default){
		return dbContext.Client.Updateable<CategoryDataModel>()
			.SetColumns(x => new CategoryDataModel {
				Sort = sort,
				UpdatedAt = DateTimeOffset.UtcNow
			})
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.ExecuteCommandAsync();
	}

	public async Task MoveSortFirstAsync(long id, CancellationToken cancellationToken = default){
		var minSort = await dbContext.Client.Queryable<CategoryDataModel>()
			.Where(x => x.IsDeleted == 0)
			.OrderBy(x => x.Sort)
			.FirstAsync();

		var nextSort = minSort is null ? 0 : checked((int)((minSort.Sort ?? 0) - 1));
		await UpdateSortAsync(id, nextSort, cancellationToken);
	}

	public async Task MoveSortLastAsync(long id, CancellationToken cancellationToken = default){
		var maxSort = await dbContext.Client.Queryable<CategoryDataModel>()
			.Where(x => x.IsDeleted == 0)
			.OrderByDescending(x => x.Sort)
			.FirstAsync();

		var nextSort = checked((int)((maxSort?.Sort ?? 0) + 1));
		await UpdateSortAsync(id, nextSort, cancellationToken);
	}

	public async Task DeleteAsync(long id, int deleteType = 1, CancellationToken cancellationToken = default){
		switch (deleteType) {
			case 1:
				await dbContext.Client.Updateable<CategoryDataModel>()
					.SetColumns(x => new CategoryDataModel { IsDeleted = 1, UpdatedAt = DateTimeOffset.UtcNow })
					.Where(x => x.Id == id)
					.ExecuteCommandAsync();
				break;
			case 2:
				await dbContext.Client.Deleteable<CategoryDataModel>()
					.Where(x => x.Id == id)
					.ExecuteCommandAsync();
				break;
			case 3:
				await dbContext.Client.Updateable<CategoryDataModel>()
					.SetColumns(x => new CategoryDataModel { IsDeleted = 0, UpdatedAt = DateTimeOffset.UtcNow })
					.Where(x => x.Id == id)
					.ExecuteCommandAsync();
				break;
			default:
				throw new ArgumentOutOfRangeException(nameof(deleteType), "Unsupported delete type.");
		}
	}

	public async Task<IReadOnlyCollection<CategoryListItemDto>> GetAsync(CancellationToken cancellationToken = default){
		var categories = await dbContext.Client.Queryable<CategoryDataModel>()
			.Where(x => x.IsDeleted == 0)
			.OrderBy(x => x.Sort)
			.OrderBy(x => x.Name)
			.ToListAsync();

		return await MapToListItemsAsync(categories, cancellationToken);
	}

	public async Task<PagedResult<CategoryListItemDto>> GetAsync(CategoryPageListQuery query,
		CancellationToken cancellationToken = default){
		var normalizedPageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var normalizedPageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (normalizedPageNumber - 1) * normalizedPageSize;
		var keyword = (query.Name ?? query.Keyword)?.Trim();

		var categoryQueryable = dbContext.Client.Queryable<CategoryDataModel>();

		if (!string.IsNullOrWhiteSpace(keyword))
			categoryQueryable = categoryQueryable.Where(x => x.Name.Contains(keyword));

		if (query.StartDate.HasValue) {
			var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			categoryQueryable = categoryQueryable.Where(x => x.CreatedAt >= start);
		}

		if (query.EndDate.HasValue) {
			var endExclusive = query.EndDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			categoryQueryable = categoryQueryable.Where(x => x.CreatedAt < endExclusive);
		}

		var totalCount = await categoryQueryable.CountAsync();
		var orderedCategoryQueryable = query.SortOrder?.ToLowerInvariant() switch {
			"timeasc" => categoryQueryable.OrderBy(x => x.CreatedAt).OrderBy(x => x.Sort).OrderBy(x => x.Name),
			"timedesc" => categoryQueryable.OrderByDescending(x => x.CreatedAt).OrderBy(x => x.Sort).OrderBy(x => x.Name),
			_ => categoryQueryable.OrderBy(x => x.Sort).OrderBy(x => x.Name).OrderByDescending(x => x.CreatedAt)
		};

		var categories = await orderedCategoryQueryable
			.Skip(skip)
			.Take(normalizedPageSize)
			.ToListAsync();

		var items = await MapToListItemsAsync(categories, cancellationToken);
		return new PagedResult<CategoryListItemDto>(items, normalizedPageNumber, normalizedPageSize, totalCount);
	}

	private async Task<CategoryListItemDto[]> MapToListItemsAsync(
		IReadOnlyCollection<CategoryDataModel> categories,
		CancellationToken cancellationToken){
		if (categories.Count == 0) return [];

		var categoryIds = categories.Select(category => category.Id).ToArray();
		var articleRelations = await dbContext.Client.Queryable<ArticleCategoryRelationDataModel>()
			.Where(relation => categoryIds.Contains(relation.CategoryId))
			.ToListAsync();

		if (articleRelations.Count == 0)
			return categories.Select(category => MapToListItem(category, 0)).ToArray();

		var articleIds = articleRelations.Select(relation => relation.ArticleId).Distinct().ToArray();
		var publishedArticleIds = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(article => articleIds.Contains(article.Id) && article.IsDeleted == 0 && article.Type == 1)
			.Select(article => article.Id)
			.ToListAsync();
		var publishedArticleIdSet = publishedArticleIds.ToHashSet();
		var categoryArticleTotals = articleRelations
			.Where(relation => publishedArticleIdSet.Contains(relation.ArticleId))
			.GroupBy(relation => relation.CategoryId)
			.ToDictionary(group => group.Key, group => group.Select(relation => relation.ArticleId).Distinct().Count());

		return categories
			.Select(category => MapToListItem(
				category,
				categoryArticleTotals.GetValueOrDefault(category.Id)))
			.ToArray();
	}

	private static CategoryListItemDto MapToListItem(CategoryDataModel category, int articlesTotal){
		return new CategoryListItemDto(category.Id, category.Name, articlesTotal, category.Sort, category.CreatedAt,
			category.IsDeleted);
	}
}
