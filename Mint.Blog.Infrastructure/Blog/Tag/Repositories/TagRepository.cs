using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagList;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagPageList;
using Mint.Blog.Domain.Blog.Tag.Repositories;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Tag.Persistence;

namespace Mint.Blog.Infrastructure.Blog.Tag.Repositories;

public sealed class TagRepository(ISqlSugarDbContext dbContext)
	: ITagRepository, IGetTagListQueryService, IGetTagPageListQueryService {
	public async Task<IReadOnlyCollection<TagListItemDto>> GetAsync(CancellationToken cancellationToken = default){
		var tags = await dbContext.Client.Queryable<TagDataModel>()
			.Where(x => x.IsDeleted == 0)
			.OrderBy(x => x.Sort)
			.OrderBy(x => x.Name)
			.ToListAsync();

		return await MapToListItemsAsync(tags, cancellationToken);
	}

	public async Task<PagedResult<TagListItemDto>> GetAsync(TagPageListQuery query,
		CancellationToken cancellationToken = default){
		var normalizedPageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var normalizedPageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (normalizedPageNumber - 1) * normalizedPageSize;
		var keyword = (query.Name ?? query.Keyword)?.Trim();

		var tagQueryable = dbContext.Client.Queryable<TagDataModel>();

		if (!string.IsNullOrWhiteSpace(keyword))
			tagQueryable = tagQueryable.Where(x => x.Name.Contains(keyword));

		if (query.StartDate.HasValue) {
			var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			tagQueryable = tagQueryable.Where(x => x.CreatedAt >= start);
		}

		if (query.EndDate.HasValue) {
			var endExclusive = query.EndDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			tagQueryable = tagQueryable.Where(x => x.CreatedAt < endExclusive);
		}

		var totalCount = await tagQueryable.CountAsync();
		var orderedTagQueryable = query.SortOrder?.ToLowerInvariant() switch {
			"timeasc" => tagQueryable.OrderBy(x => x.CreatedAt).OrderBy(x => x.Sort).OrderBy(x => x.Name),
			"timedesc" => tagQueryable.OrderByDescending(x => x.CreatedAt).OrderBy(x => x.Sort).OrderBy(x => x.Name),
			_ => tagQueryable.OrderBy(x => x.Sort).OrderBy(x => x.Name).OrderByDescending(x => x.CreatedAt)
		};

		var tags = await orderedTagQueryable
			.Skip(skip)
			.Take(normalizedPageSize)
			.ToListAsync();

		var items = await MapToListItemsAsync(tags, cancellationToken);
		return new PagedResult<TagListItemDto>(items, normalizedPageNumber, normalizedPageSize, totalCount);
	}

	public async Task<IReadOnlyCollection<long>> FilterExistingIdsAsync(IEnumerable<long> ids,
		CancellationToken cancellationToken = default){
		var idArray = ids.Distinct().ToArray();
		if (idArray.Length == 0) return [];

		var existingIds = await dbContext.Client.Queryable<TagDataModel>()
			.Where(tag => tag.IsDeleted == 0 && idArray.Contains(tag.Id))
			.Select(tag => tag.Id)
			.ToListAsync();

		return existingIds;
	}

	public Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default){
		return ExistsAsync(id, false, cancellationToken);
	}

	public Task<bool> ExistsAsync(long id, bool includeDeleted, CancellationToken cancellationToken = default){
		var query = dbContext.Client.Queryable<TagDataModel>()
			.Where(x => x.Id == id);

		if (!includeDeleted) query = query.Where(x => x.IsDeleted == 0);

		return query.AnyAsync();
	}

	public async Task<long> AddAsync(string name, CancellationToken cancellationToken = default){
		var now = DateTimeOffset.UtcNow;
		var tag = new TagDataModel {
			Name = name,
			CreatedAt = now,
			UpdatedAt = now,
			IsDeleted = 0,
			ArticlesTotal = 0,
			Sort = 0
		};

		return await dbContext.Client.Insertable(tag).ExecuteReturnSnowflakeIdAsync();
	}

	public async Task UpdateAsync(long id, string name, CancellationToken cancellationToken = default){
		var tag = await dbContext.Client.Queryable<TagDataModel>()
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.SingleAsync();

		if (tag is null) return;

		tag.Name = name;
		tag.UpdatedAt = DateTimeOffset.UtcNow;
		await dbContext.Client.Updateable(tag).ExecuteCommandAsync();
	}

	public Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default){
		return dbContext.Client.Updateable<TagDataModel>()
			.SetColumns(x => new TagDataModel {
				Sort = sort,
				UpdatedAt = DateTimeOffset.UtcNow
			})
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.ExecuteCommandAsync();
	}

	public async Task MoveSortFirstAsync(long id, CancellationToken cancellationToken = default){
		var minSort = await dbContext.Client.Queryable<TagDataModel>()
			.Where(x => x.IsDeleted == 0)
			.OrderBy(x => x.Sort)
			.FirstAsync();

		var nextSort = minSort is null ? 0 : checked((int)((minSort.Sort ?? 0) - 1));
		await UpdateSortAsync(id, nextSort, cancellationToken);
	}

	public async Task MoveSortLastAsync(long id, CancellationToken cancellationToken = default){
		var maxSort = await dbContext.Client.Queryable<TagDataModel>()
			.Where(x => x.IsDeleted == 0)
			.OrderByDescending(x => x.Sort)
			.FirstAsync();

		var nextSort = checked((int)((maxSort?.Sort ?? 0) + 1));
		await UpdateSortAsync(id, nextSort, cancellationToken);
	}

	public async Task DeleteAsync(long id, int deleteType = 1, CancellationToken cancellationToken = default){
		switch (deleteType) {
			case 1:
				await dbContext.Client.Updateable<TagDataModel>()
					.SetColumns(x => new TagDataModel {
						IsDeleted = 1,
						UpdatedAt = DateTimeOffset.UtcNow
					})
					.Where(x => x.Id == id)
					.ExecuteCommandAsync();
				break;
			case 2:
				await dbContext.Client.Deleteable<TagDataModel>()
					.Where(x => x.Id == id)
					.ExecuteCommandAsync();
				break;
			case 3:
				await dbContext.Client.Updateable<TagDataModel>()
					.SetColumns(x => new TagDataModel {
						IsDeleted = 0,
						UpdatedAt = DateTimeOffset.UtcNow
					})
					.Where(x => x.Id == id)
					.ExecuteCommandAsync();
				break;
			default:
				throw new ArgumentOutOfRangeException(nameof(deleteType), "Unsupported delete type.");
		}
	}

	private async Task<TagListItemDto[]> MapToListItemsAsync(
		IReadOnlyCollection<TagDataModel> tags,
		CancellationToken cancellationToken){
		if (tags.Count == 0) return [];

		var tagIds = tags.Select(tag => tag.Id).ToArray();
		var articleRelations = await dbContext.Client.Queryable<ArticleTagRelationDataModel>()
			.Where(relation => tagIds.Contains(relation.TagId))
			.ToListAsync();

		if (articleRelations.Count == 0)
			return tags.Select(tag => MapToListItem(tag, 0)).ToArray();

		var articleIds = articleRelations.Select(relation => relation.ArticleId).Distinct().ToArray();
		var publishedArticleIds = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(article => articleIds.Contains(article.Id) && article.IsDeleted == 0 && article.Type == 1)
			.Select(article => article.Id)
			.ToListAsync();
		var publishedArticleIdSet = publishedArticleIds.ToHashSet();
		var tagArticleTotals = articleRelations
			.Where(relation => publishedArticleIdSet.Contains(relation.ArticleId))
			.GroupBy(relation => relation.TagId)
			.ToDictionary(group => group.Key, group => group.Select(relation => relation.ArticleId).Distinct().Count());

		return tags
			.Select(tag => MapToListItem(
				tag,
				tagArticleTotals.GetValueOrDefault(tag.Id)))
			.ToArray();
	}

	private static TagListItemDto MapToListItem(TagDataModel tag, int articlesTotal){
		return new TagListItemDto(tag.Id, tag.Name, articlesTotal, tag.Sort, tag.CreatedAt, tag.IsDeleted);
	}
}
