using System.Text.RegularExpressions;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Drafts;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Domain.Blog.Article.Repositories;
using Mint.Blog.Domain.Blog.Category.Repositories;
using Mint.Blog.Domain.Blog.Tag.Repositories;
using Mint.Blog.Infrastructure.Blog.Article.Persistence;
using Mint.Blog.Infrastructure.Blog.Category.Persistence;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Article.Drafts;

public sealed partial class ArticleDraftService(
	ISqlSugarDbContext dbContext,
	IArticleRepository articleRepository,
	ICategoryRepository categoryRepository,
	ITagRepository tagRepository,
	IObjectStorageService objectStorageService,
	IUnitOfWork unitOfWork) : IArticleDraftService {
	public async Task<PagedResult<ArticleDraftListItemDto>> GetListAsync(int pageNumber, int pageSize,
		CancellationToken cancellationToken = default){
		EnsureTables();
		var normalizedPageNumber = pageNumber <= 0 ? 1 : pageNumber;
		var normalizedPageSize = pageSize <= 0 ? 20 : pageSize;
		var skip = (normalizedPageNumber - 1) * normalizedPageSize;

		var queryable = dbContext.Client.Queryable<ArticleDraftDataModel>();
		var total = await queryable.CountAsync();
		var drafts = await queryable
			.OrderByDescending(x => x.UpdatedAt)
			.Skip(skip)
			.Take(normalizedPageSize)
			.ToListAsync();

		var categoryIds = drafts.Where(x => x.CategoryId.HasValue).Select(x => x.CategoryId!.Value).Distinct().ToArray();
		var categories = categoryIds.Length == 0
			? []
			: await dbContext.Client.Queryable<CategoryDataModel>()
				.Where(x => categoryIds.Contains(x.Id))
				.ToListAsync();
		var categoryMap = categories.ToDictionary(x => x.Id, x => x.Name);

		var items = drafts.Select(x => new ArticleDraftListItemDto(
			x.Id.ToString(),
			x.ArticleId?.ToString(),
			BuildDraftTitle(x.Title),
			x.Summary,
			x.Cover,
			x.CategoryId,
			x.CategoryId.HasValue && categoryMap.TryGetValue(x.CategoryId.Value, out var categoryName) ? categoryName : string.Empty,
			!x.ArticleId.HasValue,
			x.CreatedAt,
			x.UpdatedAt)).ToArray();

		return new PagedResult<ArticleDraftListItemDto>(items, normalizedPageNumber, normalizedPageSize, total);
	}

	public async Task<ArticleDraftDto?> GetByIdAsync(long draftId, CancellationToken cancellationToken = default){
		EnsureTables();
		var draft = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(x => x.Id == draftId)
			.SingleAsync();
		return draft is null ? null : await MapToDtoAsync(draft);
	}

	public async Task<ArticleDraftDto?> GetByArticleIdAsync(long articleId,
		CancellationToken cancellationToken = default){
		EnsureTables();
		var draft = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(x => x.ArticleId == articleId)
			.OrderByDescending(x => x.UpdatedAt)
			.FirstAsync();
		return draft is null ? null : await MapToDtoAsync(draft);
	}

	public async Task<long> SaveAsync(SaveArticleDraftCommand command, CancellationToken cancellationToken = default){
		EnsureTables();
		var articleId = TryParseId(command.ArticleId);
		if (articleId.HasValue) {
			var article = await articleRepository.GetByIdAsync(articleId.Value, cancellationToken);
			Guard.Against(article is null, ErrorCodes.ArticleNotFound, "Article does not exist.");
		}

		var tagIds = command.TagIds?.Distinct().ToArray() ?? [];
		var now = DateTimeOffset.UtcNow;
		var existing = await ResolveDraftAsync(command, cancellationToken);
		var oldDraftImages = existing is null ? Array.Empty<string>() : await GetDraftImagesAsync(existing.Id);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			long draftId;
			if (existing is null) {
				var draft = new ArticleDraftDataModel {
					ArticleId = articleId,
					Title = Normalize(command.Title),
					Summary = Normalize(command.Summary),
					Cover = Normalize(command.Cover),
					CategoryId = command.CategoryId,
					CreatedAt = now,
					UpdatedAt = now
				};
				draftId = await dbContext.Client.Insertable(draft).ExecuteReturnSnowflakeIdAsync();
				await dbContext.Client.Insertable(new ArticleDraftContentDataModel {
					DraftId = draftId,
					Content = Normalize(command.Content)
				}).ExecuteReturnSnowflakeIdAsync();
			} else {
				existing.Title = Normalize(command.Title);
				existing.Summary = Normalize(command.Summary);
				existing.Cover = Normalize(command.Cover);
				existing.CategoryId = command.CategoryId;
				existing.UpdatedAt = now;
				await dbContext.Client.Updateable(existing).ExecuteCommandAsync();
				draftId = existing.Id;

				var content = await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
					.Where(x => x.DraftId == draftId)
					.SingleAsync();
				if (content is null) {
					await dbContext.Client.Insertable(new ArticleDraftContentDataModel {
						DraftId = draftId,
						Content = Normalize(command.Content)
					}).ExecuteReturnSnowflakeIdAsync();
				} else {
					content.Content = Normalize(command.Content);
					await dbContext.Client.Updateable(content).ExecuteCommandAsync();
				}
			}

			await SyncTagsAsync(draftId, tagIds);
			var newDraftImages = ToImageSet(ExtractImages(Normalize(command.Content)).Append(Normalize(command.Cover)));
			var imagesRemovedFromDraft = oldDraftImages.Except(newDraftImages, StringComparer.OrdinalIgnoreCase).ToArray();
			await unitOfWork.CommitAsync(cancellationToken);
			await CleanUnusedImagesAsync(imagesRemovedFromDraft, cancellationToken);
			return draftId;
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}

	public async Task<long> PublishAsync(long draftId, CancellationToken cancellationToken = default){
		var draft = await GetByIdAsync(draftId, cancellationToken);
		Guard.Against(draft is null, ErrorCodes.ArticleDraftNotFound, "Article draft does not exist.");
		Guard.Against(string.IsNullOrWhiteSpace(draft!.Title), ErrorCodes.ArticleTitleInvalid, "Article title is required.");
		Guard.Against(string.IsNullOrWhiteSpace(draft.Summary), ErrorCodes.ArticleSummaryInvalid, "Article summary is required.");
		Guard.Against(string.IsNullOrWhiteSpace(draft.Content), ErrorCodes.ArticleContentInvalid, "Article content is required.");
		Guard.Against(!draft.CategoryId.HasValue, ErrorCodes.CategoryNotFound, "Category does not exist.");
		Guard.Against(draft.TagIds.Count == 0, ErrorCodes.TagNotFound, "One or more tags do not exist.");

		var categoryExists = await categoryRepository.ExistsAsync(draft.CategoryId!.Value, cancellationToken);
		Guard.Against(!categoryExists, ErrorCodes.CategoryNotFound, "Category does not exist.");
		var existingTagIds = await tagRepository.FilterExistingIdsAsync(draft.TagIds, cancellationToken);
		Guard.Against(existingTagIds.Count != draft.TagIds.Distinct().Count(), ErrorCodes.TagNotFound,
			"One or more tags do not exist.");

		long articleId;
		if (draft.ArticleId.HasValue) {
			articleId = draft.ArticleId.Value;
			var article = await articleRepository.GetByIdAsync(articleId, cancellationToken);
			Guard.Against(article is null, ErrorCodes.ArticleNotFound, "Article does not exist.");
			var oldArticleImages = GetArticleImages(article!);
			var draftImages = GetDraftImages(draft);
			var imagesRemovedFromArticle = oldArticleImages.Except(draftImages, StringComparer.OrdinalIgnoreCase).ToArray();
			article!.Update(draft.Title.Trim(), draft.Summary.Trim(), draft.Content.Trim(), draft.Cover.Trim(),
				draft.CategoryId!.Value, existingTagIds);
			await unitOfWork.BeginTransactionAsync(cancellationToken);
			try {
				await articleRepository.UpdateAsync(article, cancellationToken);
				await DeleteDraftRowsAsync(draftId);
				await unitOfWork.CommitAsync(cancellationToken);
			} catch {
				await unitOfWork.RollbackAsync(cancellationToken);
				throw;
			}
			await CleanUnusedImagesAsync(imagesRemovedFromArticle, cancellationToken);
			return articleId;
		}

		var newArticle = Mint.Blog.Domain.Blog.Article.Entities.Article.Create(
			draft.Title.Trim(),
			draft.Summary.Trim(),
			draft.Content.Trim(),
			draft.Cover.Trim(),
			draft.CategoryId!.Value,
			existingTagIds);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			articleId = await articleRepository.AddAsync(newArticle, cancellationToken);
			await DeleteDraftRowsAsync(draftId);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}

		return articleId;
	}

	public async Task DeleteAsync(long draftId, CancellationToken cancellationToken = default){
		var draft = await GetByIdAsync(draftId, cancellationToken);
		Guard.Against(draft is null, ErrorCodes.ArticleDraftNotFound, "Article draft does not exist.");

		var removableImages = await GetRemovableImagesAsync(draft!, cancellationToken);

		await unitOfWork.BeginTransactionAsync(cancellationToken);
		try {
			await DeleteDraftRowsAsync(draftId);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}

		try {
			await objectStorageService.DeleteManyAsync(removableImages, cancellationToken);
		} catch {
			// 图片清理失败不应影响草稿删除结果；后续删除或人工清理可再次处理。
		}
	}

	private async Task<ArticleDraftDataModel?> ResolveDraftAsync(SaveArticleDraftCommand command,
		CancellationToken cancellationToken){
		if (!string.IsNullOrWhiteSpace(command.DraftId) && long.TryParse(command.DraftId, out var draftId)) {
			return await dbContext.Client.Queryable<ArticleDraftDataModel>()
				.Where(x => x.Id == draftId)
				.SingleAsync();
		}

		var articleId = TryParseId(command.ArticleId);
		if (!articleId.HasValue) return null;

		return await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(x => x.ArticleId == articleId.Value)
			.OrderByDescending(x => x.UpdatedAt)
			.FirstAsync();
	}

	private async Task<ArticleDraftDto> MapToDtoAsync(ArticleDraftDataModel draft){
		var content = await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.Where(x => x.DraftId == draft.Id)
			.SingleAsync();
		var tagIds = await dbContext.Client.Queryable<ArticleDraftTagRelationDataModel>()
			.Where(x => x.DraftId == draft.Id)
			.OrderBy(x => x.Id)
			.Select(x => x.TagId)
			.ToListAsync();

		return new ArticleDraftDto(
			draft.Id.ToString(),
			draft.ArticleId,
			draft.Title,
			draft.Summary,
			content?.Content ?? string.Empty,
			draft.Cover,
			draft.CategoryId,
			tagIds,
			draft.CreatedAt,
			draft.UpdatedAt);
	}

	private async Task SyncTagsAsync(long draftId, IReadOnlyCollection<long> tagIds){
		await dbContext.Client.Deleteable<ArticleDraftTagRelationDataModel>()
			.Where(x => x.DraftId == draftId)
			.ExecuteCommandAsync();

		if (tagIds.Count == 0) return;

		foreach (var tagId in tagIds) {
			await dbContext.Client.Insertable(new ArticleDraftTagRelationDataModel {
				DraftId = draftId,
				TagId = tagId
			}).ExecuteReturnSnowflakeIdAsync();
		}
	}

	private async Task DeleteDraftRowsAsync(long draftId){
		await dbContext.Client.Deleteable<ArticleDraftTagRelationDataModel>().Where(x => x.DraftId == draftId)
			.ExecuteCommandAsync();
		await dbContext.Client.Deleteable<ArticleDraftContentDataModel>().Where(x => x.DraftId == draftId)
			.ExecuteCommandAsync();
		await dbContext.Client.Deleteable<ArticleDraftDataModel>().Where(x => x.Id == draftId).ExecuteCommandAsync();
	}

	private async Task<IReadOnlyCollection<string>> GetDraftImagesAsync(long draftId){
		var draft = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(x => x.Id == draftId)
			.SingleAsync();
		if (draft is null) return [];

		var content = await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.Where(x => x.DraftId == draftId)
			.SingleAsync();

		return ToImageSet(ExtractImages(content?.Content ?? string.Empty).Append(draft.Cover));
	}

	private static IReadOnlyCollection<string> GetDraftImages(ArticleDraftDto draft) =>
		ToImageSet(ExtractImages(draft.Content).Append(draft.Cover));

	private static IReadOnlyCollection<string> GetArticleImages(Mint.Blog.Domain.Blog.Article.Entities.Article article) =>
		ToImageSet(ExtractImages(article.Content).Append(article.Cover));

	private async Task CleanUnusedImagesAsync(IReadOnlyCollection<string> images,
		CancellationToken cancellationToken = default){
		if (images.Count == 0) return;

		var removable = new List<string>();
		foreach (var image in ToImageSet(images)) {
			if (!await IsImageUsedAsync(image)) removable.Add(image);
		}

		try {
			await objectStorageService.DeleteManyAsync(removable, cancellationToken);
		} catch {
			// 图片清理失败不应回滚已提交的草稿/文章数据；后续保存、删除或人工清理可再次处理。
		}
	}

	private async Task<IReadOnlyCollection<string>> GetRemovableImagesAsync(ArticleDraftDto draft,
		CancellationToken cancellationToken){
		var draftImages = ExtractImages(draft.Content).Append(draft.Cover).Where(x => !string.IsNullOrWhiteSpace(x)).Distinct()
			.ToArray();
		if (draftImages.Length == 0) return [];

		var protectedImages = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
		if (draft.ArticleId.HasValue) {
			var article = await articleRepository.GetByIdAsync(draft.ArticleId.Value, cancellationToken);
			if (article is not null) {
				foreach (var image in ExtractImages(article.Content).Append(article.Cover)) protectedImages.Add(image);
			}
		}

		var candidates = draftImages.Where(x => !protectedImages.Contains(x)).ToArray();
		var removable = new List<string>();
		foreach (var image in candidates) {
			if (!await IsImageUsedElsewhereAsync(image, long.Parse(draft.Id))) removable.Add(image);
		}

		return removable;
	}

	private async Task<bool> IsImageUsedAsync(string image){
		var articleCoverUsed = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.Cover == image)
			.AnyAsync();
		if (articleCoverUsed) return true;

		var articleContentUsed = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.Where(x => x.Content.Contains(image))
			.AnyAsync();
		if (articleContentUsed) return true;

		var draftCoverUsed = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(x => x.Cover == image)
			.AnyAsync();
		if (draftCoverUsed) return true;

		return await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.Where(x => x.Content.Contains(image))
			.AnyAsync();
	}

	private async Task<bool> IsImageUsedElsewhereAsync(string image, long currentDraftId){
		var articleCoverUsed = await dbContext.Client.Queryable<ArticleDataModel>()
			.Where(x => x.Cover == image)
			.AnyAsync();
		if (articleCoverUsed) return true;

		var articleContentUsed = await dbContext.Client.Queryable<ArticleContentDataModel>()
			.Where(x => x.Content.Contains(image))
			.AnyAsync();
		if (articleContentUsed) return true;

		var draftCoverUsed = await dbContext.Client.Queryable<ArticleDraftDataModel>()
			.Where(x => x.Id != currentDraftId && x.Cover == image)
			.AnyAsync();
		if (draftCoverUsed) return true;

		return await dbContext.Client.Queryable<ArticleDraftContentDataModel>()
			.Where(x => x.DraftId != currentDraftId && x.Content.Contains(image))
			.AnyAsync();
	}

	private static string Normalize(string? value) => value?.Trim() ?? string.Empty;
	private static long? TryParseId(string? id) => long.TryParse(id, out var value) ? value : null;
	private void EnsureTables() => dbContext.Client.CodeFirst.InitTables<ArticleDraftDataModel, ArticleDraftContentDataModel,
		ArticleDraftTagRelationDataModel>();
	private static string BuildDraftTitle(string title) => string.IsNullOrWhiteSpace(title) ? "未命名草稿" : title;

	private static IReadOnlyCollection<string> ToImageSet(IEnumerable<string?> images) => images
		.Where(image => !string.IsNullOrWhiteSpace(image))
		.Select(image => image!.Trim())
		.Distinct(StringComparer.OrdinalIgnoreCase)
		.ToArray();

	private static IReadOnlyCollection<string> ExtractImages(string markdown){
		if (string.IsNullOrWhiteSpace(markdown)) return [];

		return MarkdownImageRegex().Matches(markdown)
			.Select(match => match.Groups[1].Value)
			.Where(x => !string.IsNullOrWhiteSpace(x))
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToArray();
	}

	[GeneratedRegex("!\\[[^\\]]*\\]\\(([^)]+)\\)")]
	private static partial Regex MarkdownImageRegex();
}
