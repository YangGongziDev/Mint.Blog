using System.Text.RegularExpressions;
using Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;
using Mint.Blog.Application.Blog.Article.Queries.GetArchiveYearList;
using Mint.Blog.Application.Blog.Article.Queries.GetArchiveYears;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleDetail;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Article.Queries.GetBlogHome;
using Mint.Blog.Application.Blog.Article.Queries.SearchArticles;
using Mint.Blog.Application.Blog.Statistics.Commands.TrackArticleRead;
using Mint.Blog.Domain.Blog.Article;
using Mint.Blog.Domain.Blog.Article.Entities;
using Mint.Blog.Domain.Blog.Article.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Category.Persistence;
using Mint.Blog.Infrastructure.Blog.Tag.Persistence;
using SqlSugar;
using ArticleEntity = Mint.Blog.Domain.Blog.Article.Entities.Article;
using ArticleTagDto = Mint.Blog.Application.Blog.Article.Queries.GetArticleList.ArticleTagDto;

namespace Mint.Blog.Infrastructure.Blog.Article.Repositories;

public sealed class ArticleRepository(ISqlSugarDbContext dbContext, IArticleReadTrackingQueue articleReadTrackingQueue)
	: IArticleRepository,
		IGetArticleDetailQueryService,
		IGetArticleListQueryService,
		IGetBlogHomeQueryService,
		ISearchArticlesQueryService,
		IGetArchivePageListQueryService,
		IGetArchiveYearListQueryService,
		IGetArchiveYearsQueryService {
	public async Task<ArticleEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default){
		var articleData = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.Id == id)
			.SingleAsync();

		if (articleData is null) return null;

		var contentData = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.Where(x => x.ArticleId == id)
			.SingleAsync();

		var categoryRelation = await dbContext.Client.Queryable<ArticleCategoryRelationDataModel>()
			.Where(x => x.ArticleId == id)
			.SingleAsync();

		var tagIds = await dbContext.Client.Queryable<ArticleTagRelationDataModel>()
			.Where(x => x.ArticleId == id)
			.OrderBy(x => x.Id)
			.Select(x => x.TagId)
			.ToListAsync();

		return MapToDomain(articleData, contentData?.Content ?? string.Empty, categoryRelation?.CategoryId ?? 0,
			tagIds);
	}

	public async Task<IReadOnlyCollection<ArticleEntity>> GetPagedListAsync(int pageNumber, int pageSize,
		CancellationToken cancellationToken = default){
		var query = new ArticleListQuery(pageNumber, pageSize);
		var result = await GetAsync(query, cancellationToken);

		return result.Items
			.Select(item => ArticleEntity.Rehydrate(
				item.Id,
				item.Title,
				item.Summary,
				string.Empty,
				item.Cover,
				item.CategoryId,
				item.Tags.Select(x => x.Id),
				item.IsTop,
				(ArticleVisibility)item.Visibility,
				false,
				item.ReadCount,
				item.CreatedAt,
				item.CreatedAt))
			.ToArray();
	}

	public async Task<long> AddAsync(ArticleEntity article, CancellationToken cancellationToken = default){
		var articleData = new ArticleDataModel {
			Title = article.Title,
			Summary = article.Summary,
			Cover = article.Cover,
			IsDeleted = article.IsDeleted ? (short)1 : (short)0,
			ReadCount = article.ReadCount,
			Weight = article.IsTop ? 1 : 0,
			Visibility = (short)article.Visibility,
			CreatedAt = article.CreatedAt,
			UpdatedAt = article.UpdatedAt
		};

		var articleId = await dbContext.Client.Insertable(articleData).ExecuteReturnSnowflakeIdAsync();

		await dbContext.Client.Insertable(new ArticleContentDataModel {
			ArticleId = articleId,
			Content = article.Content
		}).ExecuteReturnSnowflakeIdAsync();

		await dbContext.Client.Insertable(new ArticleCategoryRelationDataModel {
			ArticleId = articleId,
			CategoryId = article.CategoryId
		}).ExecuteReturnSnowflakeIdAsync();

		await SyncTagRelationsAsync(articleId, article.TagIds);
		return articleId;
	}

	public async Task UpdateAsync(ArticleEntity article, CancellationToken cancellationToken = default){
		var existingArticle = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.Id == article.Id)
			.SingleAsync();
		if (existingArticle is null) return;

		existingArticle.Title = article.Title;
		existingArticle.Summary = article.Summary;
		existingArticle.Cover = article.Cover;
		existingArticle.Visibility = (short)article.Visibility;
		existingArticle.IsDeleted = article.IsDeleted ? (short)1 : (short)0;
		existingArticle.ReadCount = article.ReadCount;
		existingArticle.Weight = article.IsTop ? 1 : 0;
		existingArticle.UpdatedAt = article.UpdatedAt;

		await dbContext.Client.Updateable(existingArticle).ExecuteCommandAsync();

		var existingContent = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.Where(x => x.ArticleId == article.Id)
			.SingleAsync();

		if (existingContent is null) {
			await dbContext.Client.Insertable(new ArticleContentDataModel {
				ArticleId = article.Id,
				Content = article.Content
			}).ExecuteReturnSnowflakeIdAsync();
		} else {
			existingContent.Content = article.Content;
			await dbContext.Client.Updateable(existingContent).ExecuteCommandAsync();
		}

		await dbContext.Client.Deleteable<ArticleCategoryRelationDataModel>()
			.Where(x => x.ArticleId == article.Id)
			.ExecuteCommandAsync();

		await dbContext.Client.Insertable(new ArticleCategoryRelationDataModel {
			ArticleId = article.Id,
			CategoryId = article.CategoryId
		}).ExecuteReturnSnowflakeIdAsync();

		await SyncTagRelationsAsync(article.Id, article.TagIds);
	}

	public async Task DeleteAsync(long id, long deleteType, CancellationToken cancellationToken = default){
		if (deleteType == 1) {
			await dbContext.Client.Updateable<ArticleDataModel>()
				.SetColumns(x => new ArticleDataModel {
					IsDeleted = 1,
					UpdatedAt = DateTimeOffset.UtcNow
				})
				.Where(x => x.Id == id)
				.ExecuteCommandAsync();
			return;
		}

		if (deleteType == 3) {
			await dbContext.Client.Updateable<ArticleDataModel>()
				.SetColumns(x => new ArticleDataModel {
					IsDeleted = 0,
					UpdatedAt = DateTimeOffset.UtcNow
				})
				.Where(x => x.Id == id)
				.ExecuteCommandAsync();
			return;
		}

		await dbContext.Client.Deleteable<ArticleTagRelationDataModel>()
			.Where(x => x.ArticleId == id)
			.ExecuteCommandAsync();

		await dbContext.Client.Deleteable<ArticleCategoryRelationDataModel>()
			.Where(x => x.ArticleId == id)
			.ExecuteCommandAsync();

		await dbContext.Client.Deleteable<ArticleContentDataModel>()
			.Where(x => x.ArticleId == id)
			.ExecuteCommandAsync();

		await dbContext.Client.Deleteable<ArticleDataModel>()
			.Where(x => x.Id == id)
			.ExecuteCommandAsync();
	}

	public async Task<PagedResult<ArchiveMonthGroupDto>> GetAsync(GetArchivePageListQuery query,
		CancellationToken cancellationToken = default){
		var normalizedPageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var normalizedPageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (normalizedPageNumber - 1) * normalizedPageSize;

		var articleQueryable = dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.Visibility == (short)ArticleVisibility.Public);

		var totalCount = await articleQueryable.CountAsync();
		var articles = await articleQueryable
			.OrderByDescending(x => x.CreatedAt)
			.Skip(skip)
			.Take(normalizedPageSize)
			.ToListAsync();

		var groups = BuildArchiveGroups(articles);
		return new PagedResult<ArchiveMonthGroupDto>(groups, normalizedPageNumber, normalizedPageSize, totalCount);
	}

	public async Task<IReadOnlyCollection<ArchiveMonthGroupDto>> GetAsync(GetArchiveYearListQuery query,
		CancellationToken cancellationToken = default){
		var start = new DateTimeOffset(new DateTime(query.Year, 1, 1, 0, 0, 0, DateTimeKind.Utc));
		var endExclusive = start.AddYears(1);

		var articles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.Visibility == (short)ArticleVisibility.Public && x.CreatedAt >= start && x.CreatedAt < endExclusive)
			.OrderByDescending(x => x.CreatedAt)
			.ToListAsync();

		return BuildArchiveGroups(articles);
	}

	public async Task<IReadOnlyCollection<ArchiveYearDto>> GetAsync(CancellationToken cancellationToken = default){
		var articles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.Visibility == (short)ArticleVisibility.Public)
			.ToListAsync();

		return articles
			.GroupBy(x => x.CreatedAt.Year)
			.Select(group => new ArchiveYearDto(group.Key, group.Count()))
			.OrderByDescending(x => x.Year)
			.ToArray();
	}

	public async Task<ArticleDetailDto?> GetAsync(ArticleDetailQuery query,
		CancellationToken cancellationToken = default){
		var article = await GetByIdAsync(query.ArticleId, cancellationToken);
		if (article is null || article.IsDeleted) return null;

		await articleReadTrackingQueue.EnqueueAsync(new TrackArticleReadCommand(article.Id), cancellationToken);
		article.IncreaseReadCount();

		var category = await dbContext.Client.Queryable<CategoryDataModel>()
			.Where(x => x.Id == article.CategoryId)
			.SingleAsync();

		var tags = article.TagIds.Count == 0
			? []
			: await dbContext.Client.Queryable<TagDataModel>()
				.Where(x => article.TagIds.Contains(x.Id))
				.OrderBy(x => x.Name)
				.ToListAsync();

		return new ArticleDetailDto(
			article.Id,
			article.Title,
			article.Summary,
			article.Content,
			article.Cover,
			article.CategoryId,
			category?.Name ?? string.Empty,
			tags.Select(tag =>
				new Mint.Blog.Application.Blog.Article.Queries.GetArticleDetail.ArticleTagDto(tag.Id, tag.Name)).ToArray(),
			article.IsTop,
			(short)article.Visibility,
			article.ReadCount,
			article.CreatedAt,
			article.UpdatedAt);
	}

	public async Task<PagedResult<ArticleListItemDto>> GetAsync(ArticleListQuery query,
		CancellationToken cancellationToken = default){
		return await GetListAsync(query.PageNumber, query.PageSize, query.CategoryId, query.TagId, query.Title,
			query.StartDate, query.EndDate, query.SortOrder, query.IncludeColumnOnly, cancellationToken);
	}

	public async Task<BlogHomeDto> GetAsync(BlogHomeQuery query, CancellationToken cancellationToken = default){
		var latestCount = query.LatestArticleCount <= 0 ? 8 : query.LatestArticleCount;
		var hotCount = query.HotArticleCount <= 0 ? 8 : query.HotArticleCount;
		var topCount = query.TopArticleCount <= 0 ? 5 : query.TopArticleCount;

		var latestArticles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.Visibility == (short)ArticleVisibility.Public)
			.OrderByDescending(x => x.CreatedAt)
			.Take(latestCount)
			.ToListAsync();

		var hotArticles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.Visibility == (short)ArticleVisibility.Public)
			.OrderByDescending(x => x.ReadCount)
			.OrderByDescending(x => x.CreatedAt)
			.Take(hotCount)
			.ToListAsync();

		var topArticles = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.Visibility == (short)ArticleVisibility.Public && x.Weight > 0)
			.OrderByDescending(x => x.Weight)
			.OrderByDescending(x => x.CreatedAt)
			.Take(topCount)
			.ToListAsync();

		var allArticleIds = latestArticles
			.Concat(hotArticles)
			.Concat(topArticles)
			.Select(x => x.Id)
			.Distinct()
			.ToArray();

		var articleView = await BuildArticleViewAsync(allArticleIds, cancellationToken);

		return new BlogHomeDto(
			latestArticles.Select(article => MapToBlogHomeItem(article, articleView)).ToArray(),
			hotArticles.Select(article => MapToBlogHomeItem(article, articleView)).ToArray(),
			topArticles.Select(article => MapToBlogHomeItem(article, articleView)).ToArray());
	}

	public async Task<PagedResult<SearchArticleItemDto>> GetAsync(SearchArticlesQuery query,
		CancellationToken cancellationToken = default){
		var normalizedKeyword = query.Keyword.Trim();
		var normalizedPageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var normalizedPageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (normalizedPageNumber - 1) * normalizedPageSize;

		var articleQueryable = dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.IsDeleted == 0 && x.Visibility == (short)ArticleVisibility.Public);

		articleQueryable = ApplyKeywordFilter(articleQueryable, normalizedKeyword);
		var totalCount = await articleQueryable.CountAsync();

		var articles = await ApplySearchOrdering(articleQueryable, normalizedKeyword)
			.Skip(skip)
			.Take(normalizedPageSize)
			.Select(x => new ArticleDataModel {
				Id = x.Id,
				Title = x.Title,
				Summary = x.Summary,
				Cover = x.Cover,
				CreatedAt = x.CreatedAt
			})
			.ToListAsync();

		var items = articles
			.Select(item => new SearchArticleItemDto(
				item.Id,
				item.Title,
				HighlightKeyword(item.Title, normalizedKeyword),
				item.Summary,
				item.Cover,
				item.CreatedAt))
			.ToArray();

		return new PagedResult<SearchArticleItemDto>(items, normalizedPageNumber, normalizedPageSize, totalCount);
	}

	private async Task<PagedResult<ArticleListItemDto>> GetListAsync(
		int pageNumber,
		int pageSize,
		long? categoryId,
		long? tagId,
		string? keyword,
		DateOnly? startDate,
		DateOnly? endDate,
		string? sortOrder,
		bool includeColumnOnly,
		CancellationToken cancellationToken){
		var normalizedPageNumber = pageNumber <= 0 ? 1 : pageNumber;
		var normalizedPageSize = pageSize <= 0 ? 10 : pageSize;
		var skip = (normalizedPageNumber - 1) * normalizedPageSize;

		var filteredArticleIds = tagId.HasValue
			? await dbContext.Client.Queryable<ArticleTagRelationDataModel>()
				.Where(x => x.TagId == tagId.Value)
				.Select(x => x.ArticleId)
				.Distinct()
				.ToListAsync()
			: null;

		var articleQueryable = dbContext.Client.Queryable<ArticleDataModel>();
		articleQueryable = includeColumnOnly
			? articleQueryable.Where(x => x.Visibility == (short)ArticleVisibility.Public || x.Visibility == (short)ArticleVisibility.ColumnOnly)
			: articleQueryable.Where(x => x.Visibility == (short)ArticleVisibility.Public);

		if (categoryId.HasValue) {
			var categoryArticleIds = await dbContext.Client.Queryable<ArticleCategoryRelationDataModel>()
				.Where(x => x.CategoryId == categoryId.Value)
				.Select(x => x.ArticleId)
				.ToListAsync();

			if (categoryArticleIds.Count == 0)
				return new PagedResult<ArticleListItemDto>([], normalizedPageNumber, normalizedPageSize, 0);

			articleQueryable = articleQueryable.Where(x => categoryArticleIds.Contains(x.Id));
		}

		if (filteredArticleIds is not null) {
			if (filteredArticleIds.Count == 0)
				return new PagedResult<ArticleListItemDto>([], normalizedPageNumber, normalizedPageSize, 0);

			articleQueryable = articleQueryable.Where(x => filteredArticleIds.Contains(x.Id));
		}

		if (!string.IsNullOrWhiteSpace(keyword))
			articleQueryable = articleQueryable.Where(x => x.Title.Contains(keyword.Trim()));

		if (startDate.HasValue) {
			var start = startDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			articleQueryable = articleQueryable.Where(x => x.CreatedAt >= start);
		}

		if (endDate.HasValue) {
			var endExclusive = endDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			articleQueryable = articleQueryable.Where(x => x.CreatedAt < endExclusive);
		}

		var totalCount = await articleQueryable.CountAsync();

		var orderedArticleQueryable = sortOrder?.ToLowerInvariant() switch {
			"timeasc" => articleQueryable.OrderBy(x => x.CreatedAt).OrderByDescending(x => x.Weight),
			"timedesc" => articleQueryable.OrderByDescending(x => x.CreatedAt).OrderByDescending(x => x.Weight),
			_ => articleQueryable.OrderByDescending(x => x.Weight).OrderByDescending(x => x.CreatedAt)
		};

		var articles = await orderedArticleQueryable
			.Skip(skip)
			.Take(normalizedPageSize)
			.ToListAsync();

		if (articles.Count == 0)
			return new PagedResult<ArticleListItemDto>([], normalizedPageNumber, normalizedPageSize, totalCount);

		var articleIds = articles.Select(x => x.Id).ToArray();
		var articleView = await BuildArticleViewAsync(articleIds, cancellationToken);

		var items = articles
			.Select(article => MapToListItem(article, articleView))
			.ToArray();

		return new PagedResult<ArticleListItemDto>(items, normalizedPageNumber, normalizedPageSize, totalCount);
	}

	private static ISugarQueryable<ArticleDataModel> ApplyKeywordFilter(
		ISugarQueryable<ArticleDataModel> articleQueryable, string keyword){
		if (articleQueryable.Context.CurrentConnectionConfig.DbType == DbType.PostgreSQL) {
			if (ContainsChinese(keyword)) {
				var likeKeyword = EscapeLikeKeyword(keyword);
				var likeSql =
					$"(coalesce(title, '') like '%{likeKeyword}%' escape '\\' or coalesce(summary, '') like '%{likeKeyword}%' escape '\\')";
				return articleQueryable.Where(likeSql);
			}

			var escapedKeyword = keyword.Replace("'", "''");
			var searchSql =
				$"to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(summary, '')) @@ to_tsquery('simple', '{escapedKeyword}:*')";
			return articleQueryable.Where(searchSql);
		}

		return articleQueryable.Where(x => x.Title.Contains(keyword) || x.Summary.Contains(keyword));
	}

	private static ISugarQueryable<ArticleDataModel> ApplySearchOrdering(
		ISugarQueryable<ArticleDataModel> articleQueryable, string? keyword){
		if (!string.IsNullOrWhiteSpace(keyword) &&
		    articleQueryable.Context.CurrentConnectionConfig.DbType == DbType.PostgreSQL) {
			var escapedKeyword = keyword.Trim().Replace("'", "''");
			var rankSql =
				$"ts_rank(to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(summary, '')), to_tsquery('simple', '{escapedKeyword}:*')) desc";
			return articleQueryable
				.OrderBy(rankSql)
				.OrderByDescending(x => x.Weight)
				.OrderByDescending(x => x.CreatedAt);
		}

		return articleQueryable
			.OrderByDescending(x => x.Weight)
			.OrderByDescending(x => x.CreatedAt);
	}

	private static string HighlightKeyword(string text, string keyword){
		if (string.IsNullOrWhiteSpace(text) || string.IsNullOrWhiteSpace(keyword)) return text;

		return Regex.Replace(
			text,
			Regex.Escape(keyword),
			match => $"<span style=\"color: #f73131\">{match.Value}</span>",
			RegexOptions.IgnoreCase);
	}

	private static bool ContainsChinese(string keyword){
		return keyword.Any(ch => ch >= '\u4e00' && ch <= '\u9fff');
	}

	private static string EscapeLikeKeyword(string keyword){
		return keyword
			.Replace("\\", "\\\\")
			.Replace("%", "\\%")
			.Replace("_", "\\_")
			.Replace("'", "''");
	}

	private async Task<ArticleViewData> BuildArticleViewAsync(IReadOnlyCollection<long> articleIds,
		CancellationToken cancellationToken){
		if (articleIds.Count == 0)
			return new ArticleViewData(
				new Dictionary<long, long>(),
				new Dictionary<long, string>(),
				new Dictionary<long, IReadOnlyCollection<
					ArticleTagDto>>());

		var categoryRelations = await dbContext.Client.Queryable<ArticleCategoryRelationDataModel>()
			.Where(x => articleIds.Contains(x.ArticleId))
			.ToListAsync();

		var categoryIds = categoryRelations.Select(x => x.CategoryId).Distinct().ToArray();
		var categories = categoryIds.Length == 0
			? []
			: await dbContext.Client.Queryable<CategoryDataModel>()
				.Where(x => categoryIds.Contains(x.Id))
				.ToListAsync();

		var relations = await dbContext.Client.Queryable<ArticleTagRelationDataModel>()
			.Where(x => articleIds.Contains(x.ArticleId))
			.OrderBy(x => x.Id)
			.ToListAsync();

		var tagIds = relations.Select(x => x.TagId).Distinct().ToArray();
		var tags = tagIds.Length == 0
			? []
			: await dbContext.Client.Queryable<TagDataModel>()
				.Where(x => tagIds.Contains(x.Id))
				.ToListAsync();

		var articleCategoryLookup = categoryRelations
			.GroupBy(x => x.ArticleId)
			.ToDictionary(group => group.Key, group => group.First().CategoryId);

		var categoryNameLookup = categories.ToDictionary(x => x.Id, x => x.Name);
		var tagLookup = tags.ToDictionary(x => x.Id, x => x.Name);
		var articleTagsLookup = relations
			.GroupBy(x => x.ArticleId)
			.ToDictionary(
				group => group.Key,
				group => (IReadOnlyCollection<ArticleTagDto>)group
					.Where(x => tagLookup.ContainsKey(x.TagId))
					.Select(x =>
						new ArticleTagDto(x.TagId,
							tagLookup[x.TagId]))
					.ToArray());

		return new ArticleViewData(articleCategoryLookup, categoryNameLookup, articleTagsLookup);
	}

	private static IReadOnlyCollection<ArchiveMonthGroupDto> BuildArchiveGroups(
		IReadOnlyCollection<ArticleDataModel> articles){
		return articles
			.GroupBy(article => new DateOnly(article.CreatedAt.Year, article.CreatedAt.Month, 1))
			.OrderByDescending(group => group.Key)
			.Select(group => new ArchiveMonthGroupDto(
				group.Key.ToString("yyyy-MM"),
				group
					.OrderByDescending(article => article.CreatedAt)
					.Select(article => new ArchiveArticleDto(
						article.Id,
						article.Cover,
						article.Title,
						DateOnly.FromDateTime(article.CreatedAt.UtcDateTime.Date)))
					.ToArray()))
			.ToArray();
	}

	private static ArticleListItemDto MapToListItem(ArticleDataModel article, ArticleViewData viewData){
		var categoryId = viewData.ArticleCategoryLookup.GetValueOrDefault(article.Id, 0);

		return new ArticleListItemDto(
			article.Id,
			article.Title,
			article.Summary,
			article.Cover,
			categoryId,
			viewData.CategoryNameLookup.GetValueOrDefault(categoryId, string.Empty),
			viewData.ArticleTagsLookup.GetValueOrDefault(article.Id, []),
			article.Weight > 0,
			article.Visibility,
			article.IsDeleted,
			article.ReadCount,
			article.CreatedAt);
	}

	private static BlogHomeArticleDto MapToBlogHomeItem(ArticleDataModel article, ArticleViewData viewData){
		var tags = viewData.ArticleTagsLookup.GetValueOrDefault(article.Id, []);
		var categoryId = viewData.ArticleCategoryLookup.GetValueOrDefault(article.Id, 0);

		return new BlogHomeArticleDto(
			article.Id,
			article.Title,
			article.Summary,
			article.Cover,
			categoryId,
			viewData.CategoryNameLookup.GetValueOrDefault(categoryId, string.Empty),
			tags.Select(x => x.Name).ToArray(),
			article.Weight > 0,
			article.ReadCount,
			article.CreatedAt);
	}

	private async Task SyncTagRelationsAsync(long articleId, IReadOnlyCollection<long> tagIds){
		await dbContext.Client.Deleteable<ArticleTagRelationDataModel>()
			.Where(x => x.ArticleId == articleId)
			.ExecuteCommandAsync();

		if (tagIds.Count == 0) return;

		var nextRelationId = await GetNextArticleTagRelationIdAsync();
		var relations = tagIds
			.Distinct()
			.Select(tagId => new ArticleTagRelationDataModel {
				Id = nextRelationId++,
				ArticleId = articleId,
				TagId = tagId
			})
			.ToArray();

		await dbContext.Client.Insertable(relations).ExecuteCommandAsync();
	}

	private async Task<long> GetNextArticleTagRelationIdAsync(){
		var maxId = await dbContext.Client.Queryable<ArticleTagRelationDataModel>()
			.OrderByDescending(x => x.Id)
			.Select(x => x.Id)
			.FirstAsync();

		return maxId <= 0 ? 1 : maxId + 1;
	}

	private static ArticleEntity MapToDomain(ArticleDataModel data, string content, long categoryId,
		IReadOnlyCollection<long> tagIds){
		return ArticleEntity.Rehydrate(
			data.Id,
			data.Title,
			data.Summary,
			content,
			data.Cover,
			categoryId,
			tagIds,
			data.Weight > 0,
			(ArticleVisibility)data.Visibility,
			data.IsDeleted != 0,
			data.ReadCount,
			data.CreatedAt,
			data.UpdatedAt);
	}

	private sealed record ArticleViewData(
		IReadOnlyDictionary<long, long> ArticleCategoryLookup,
		IReadOnlyDictionary<long, string> CategoryNameLookup,
		IReadOnlyDictionary<long,
				IReadOnlyCollection<ArticleTagDto>>
			ArticleTagsLookup);
}
