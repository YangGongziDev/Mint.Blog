using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Column;
using Mint.Blog.Model.Entitys.Blog.Column;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Column;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class ColumnService(IColumnRepository columnRepository, IUnitOfWork unitOfWork) : IColumnService {
    public async Task<long> CreateAsync(CreateColumnCommand command, CancellationToken cancellationToken = default) {
        Validate(command.Title, command.Summary, command.Cover);
        var title = command.Title.Trim();
        Guard.Against(await columnRepository.ExistsByTitleAsync(title, null, cancellationToken), ErrorCodes.ColumnTitleDuplicate, "Column title already exists.");
        var now = DateTimeOffset.UtcNow;
        var column = new ColumnDataModel { Title = title, Summary = command.Summary.Trim(), Cover = command.Cover.Trim(), IsPublish = 1, CreatedAt = now, UpdatedAt = now };
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var id = await columnRepository.AddAsync(column, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
            return id;
        } catch {
            await unitOfWork.RollbackAsync(cancellationToken);
            throw;
        }
    }
    public async Task UpdateAsync(UpdateColumnCommand command, CancellationToken cancellationToken = default) {
        Validate(command.Title, command.Summary, command.Cover);
        var column = await RequireAsync(command.ColumnId, cancellationToken);
        var title = command.Title.Trim();
        Guard.Against(await columnRepository.ExistsByTitleAsync(title, command.ColumnId, cancellationToken), ErrorCodes.ColumnTitleDuplicate, "Column title already exists.");
        column.Title = title;
        column.Summary = command.Summary.Trim();
        column.Cover = command.Cover.Trim();
        column.UpdatedAt = DateTimeOffset.UtcNow;
        await SaveAsync(column, cancellationToken);
    }
    public async Task SetPublishAsync(SetColumnPublishCommand command, CancellationToken cancellationToken = default) {
        var column = await RequireAsync(command.ColumnId, cancellationToken);
        if ((column.IsPublish != 0) != command.IsPublish) {
            column.IsPublish = command.IsPublish ? (short)1 : (short)0;
            column.UpdatedAt = DateTimeOffset.UtcNow;
        }
        await SaveAsync(column, cancellationToken);
    }
    public async Task SetTopAsync(SetColumnTopCommand command, CancellationToken cancellationToken = default) {
        var column = await RequireAsync(command.ColumnId, cancellationToken);
        column.Weight = command.IsTop ? 1 : 0;
        column.UpdatedAt = DateTimeOffset.UtcNow;
        await SaveAsync(column, cancellationToken);
    }
    public async Task UpdateSortAsync(UpdateColumnSortCommand command, CancellationToken cancellationToken = default) {
        var move = command.Move?.Trim().ToLowerInvariant();
        if (move is not null && move is not ("up" or "down" or "first" or "last"))
            throw new ArgumentException("Move must be up, down, first or last.", nameof(command.Move));
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            if (move is null) {
                await RequireAsync(command.ColumnId, cancellationToken);
                await columnRepository.UpdateSortAsync(command.ColumnId, command.Sort, cancellationToken);
            } else {
                var found = await columnRepository.MoveAsync(command.ColumnId, move, cancellationToken);
                Guard.Against(!found, ErrorCodes.ColumnNotFound, "Column not found.");
            }
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(cancellationToken);
            throw;
        }
    }
    public async Task DeleteAsync(DeleteColumnCommand command, CancellationToken cancellationToken = default) {
        var column = await RequireAsync(command.ColumnId, cancellationToken);
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            switch (command.DeleteType) {
                case 1:
                case 3:
                    var deleted = command.DeleteType == 1 ? (short)1 : (short)0;
                    if (column.IsDeleted != deleted) {
                        column.IsDeleted = deleted;
                        column.UpdatedAt = DateTimeOffset.UtcNow;
                    }
                    await columnRepository.UpdateAsync(column, cancellationToken);
                    break;
                case 2:
                    await columnRepository.DeleteAsync(command.ColumnId, cancellationToken);
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(command.DeleteType), "Unsupported delete type.");
            }
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(cancellationToken);
            throw;
        }
    }
    public async Task UpdateCatalogAsync(UpdateColumnCatalogCommand command, CancellationToken cancellationToken = default) {
        await RequireAsync(command.ColumnId, cancellationToken);
        var normalized = new List<ColumnCatalogUpsertModel>();
        for (var i = 0; i < command.Catalogs.Count; i++) {
            var parent = command.Catalogs.ElementAt(i);
            normalized.Add(new ColumnCatalogUpsertModel(parent.Title.Trim(), null, 1, 0, i + 1, parent.IsDeleted));
            for (var j = 0; j < parent.Children.Count; j++) {
                var child = parent.Children.ElementAt(j);
                normalized.Add(new ColumnCatalogUpsertModel(child.Title.Trim(), child.ArticleId > 0 ? child.ArticleId : null, 2, i + 1, j + 1, child.IsDeleted));
            }
        }
        var ids = normalized.Where(x => x.ArticleId.HasValue && x.ArticleId > 0).Select(x => x.ArticleId!.Value).ToArray();
        var duplicates = command.Catalogs.SelectMany(parent => parent.Children.Where(child => child.ArticleId > 0)
            .Select(child => new { child.ArticleId, CatalogTitle = child.Title.Trim() })).GroupBy(x => x.ArticleId).Where(x => x.Count() > 1).ToArray();
        if (duplicates.Length > 0) {
            var titles = await columnRepository.GetArticleTitlesAsync(duplicates.Select(x => x.Key).ToArray(), cancellationToken);
            var message = string.Join("；", duplicates.Select(group => {
                var title = titles.TryGetValue(group.Key, out var value) ? value : $"ID {group.Key}";
                return $"{string.Join(" 和 ", group.Select(x => $"目录：{x.CatalogTitle}"))} 引用了相同的文章：{title}";
            }));
            Guard.Against(true, ErrorCodes.ColumnCatalogArticleDuplicate, message);
        }
        if (ids.Length > 0) {
            var distinct = ids.Distinct().ToArray();
            var existing = (await columnRepository.GetExistingArticleIdsAsync(distinct, cancellationToken)).ToHashSet();
            var invalid = distinct.Where(id => !existing.Contains(id)).ToArray();
            Guard.Against(invalid.Length > 0, ErrorCodes.ArticleNotFound, $"以下文章 ID 不存在或已删除：{string.Join(", ", invalid)}");
            var occupied = await columnRepository.FilterOccupiedArticleIdsAsync(command.ColumnId, distinct, cancellationToken);
            Guard.Against(occupied.Count > 0, ErrorCodes.ColumnCatalogArticleOccupied, $"以下文章 ID 已被其他专栏占用：{string.Join(", ", occupied)}");
        }
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            await columnRepository.UpdateCatalogAsync(command.ColumnId, normalized, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(cancellationToken);
            throw;
        }
    }
    public async Task<PagedResult<AdminColumnPageItemDto>> GetAsync(GetAdminColumnPageListQuery query, CancellationToken cancellationToken = default) {
        var page = await columnRepository.GetPageAsync(query, cancellationToken);
        if (page.Items.Count == 0) return new PagedResult<AdminColumnPageItemDto>([], page.PageNumber, page.PageSize, page.TotalCount);
        var catalogs = await columnRepository.GetCatalogsAsync(page.Items.Select(x => x.Id).ToArray(), cancellationToken);
        var valid = await ValidArticlesAsync(catalogs, cancellationToken);
        return new PagedResult<AdminColumnPageItemDto>(page.Items.Select(x => new AdminColumnPageItemDto(x.Id, x.Title, x.Cover, x.Summary,
            x.Sort, x.Weight, x.CreatedAt, x.Weight > 0, x.IsPublish != 0,
            catalogs.Count(c => c.ColumnId == x.Id && c.ArticleId.HasValue && c.ArticleId > 0 && valid.Contains(c.ArticleId.Value)), x.IsDeleted)).ToArray(),
            page.PageNumber, page.PageSize, page.TotalCount);
    }
    public async Task<IReadOnlyCollection<AdminColumnCatalogItemDto>> GetAsync(long columnId, CancellationToken cancellationToken = default) {
        var catalogs = await columnRepository.GetCatalogsAsync([columnId], cancellationToken);
        return catalogs.Where(x => x.Level == 1).OrderBy(x => x.Sort).ThenBy(x => x.Id).Select(parent =>
            new AdminColumnCatalogItemDto(parent.Id, parent.ArticleId ?? 0, parent.Title, parent.Sort, parent.Level, parent.IsDeleted != 0, false,
                catalogs.Where(x => x.ParentId == parent.Id && x.Level == 2).OrderBy(x => x.Sort).ThenBy(x => x.Id)
                    .Select(child => new AdminColumnCatalogItemDto(child.Id, child.ArticleId ?? 0, child.Title, child.Sort, child.Level, child.IsDeleted != 0, false, [])).ToArray())).ToArray();
    }
    public async Task<IReadOnlyCollection<BlogColumnListItemDto>> GetAsync(CancellationToken cancellationToken = default) {
        var columns = await columnRepository.GetPublishedAsync(cancellationToken);
        if (columns.Count == 0) return [];
        var catalogs = await columnRepository.GetCatalogsAsync(columns.Select(x => x.Id).ToArray(), cancellationToken);
        var valid = await ValidArticlesAsync(catalogs, cancellationToken);
        return columns.Select(column => {
            var rows = catalogs.Where(x => x.ColumnId == column.Id).ToArray();
            var first = rows.Where(x => x.Level == 2 && x.ArticleId.HasValue && x.ArticleId > 0 && valid.Contains(x.ArticleId.Value))
                .OrderBy(x => x.Id).Select(x => x.ArticleId).FirstOrDefault();
            return new BlogColumnListItemDto(column.Id, column.Cover, column.Title,
                rows.Count(x => x.ArticleId.HasValue && x.ArticleId > 0 && valid.Contains(x.ArticleId.Value)), column.Summary,
                column.Sort, column.Weight, column.Weight > 0, first);
        }).ToArray();
    }
    public async Task<IReadOnlyCollection<BlogColumnCatalogItemDto>> GetAsync(BlogColumnCatalogQuery query, CancellationToken cancellationToken = default) {
        if (!await PublishedAsync(query.ColumnId, cancellationToken)) return [];
        var catalogs = await columnRepository.GetCatalogsAsync([query.ColumnId], cancellationToken);
        var valid = await ValidArticlesAsync(catalogs, cancellationToken);
        return catalogs.Where(x => x.Level == 1).OrderBy(x => x.Sort).ThenBy(x => x.Id).Select(parent =>
            new BlogColumnCatalogItemDto(parent.Id, parent.ArticleId ?? 0, parent.Title, parent.Level,
                catalogs.Where(x => x.ParentId == parent.Id && x.Level == 2 && x.ArticleId.HasValue && x.ArticleId > 0 && valid.Contains(x.ArticleId.Value))
                    .OrderBy(x => x.Sort).ThenBy(x => x.Id).Select(child => new BlogColumnCatalogItemDto(child.Id, child.ArticleId ?? 0, child.Title, child.Level, [])).ToArray())).ToArray();
    }
    public async Task<BlogColumnArticlePreNextDto> GetAsync(BlogColumnArticlePreNextQuery query, CancellationToken cancellationToken = default) {
        if (!await PublishedAsync(query.ColumnId, cancellationToken)) return new(null, null);
        var catalogs = await columnRepository.GetCatalogsAsync([query.ColumnId], cancellationToken);
        if (catalogs.Count == 0) return new(null, null);
        var valid = await ValidArticlesAsync(catalogs, cancellationToken);
        var articles = catalogs.Where(x => x.Level == 2 && x.ArticleId.HasValue && valid.Contains(x.ArticleId.Value)).OrderBy(x => x.Sort).ThenBy(x => x.Id).ToArray();
        var index = Array.FindIndex(articles, x => x.ArticleId == query.ArticleId);
        if (index < 0) return new(null, null);
        var previous = index > 0 ? articles[index - 1] : null;
        var next = index < articles.Length - 1 ? articles[index + 1] : null;
        return new(previous is null ? null : new(previous.ArticleId ?? 0, previous.Title), next is null ? null : new(next.ArticleId ?? 0, next.Title));
    }
    private async Task<bool> PublishedAsync(long id, CancellationToken ct) {
        var column = await columnRepository.GetByIdAsync(id, ct);
        return column is not null && column.IsPublish != 0 && column.IsDeleted == 0;
    }
    private Task<IReadOnlySet<long>> ValidArticlesAsync(IReadOnlyCollection<ColumnCatalogDataModel> catalogs, CancellationToken ct) =>
        columnRepository.GetValidArticleIdsAsync(catalogs.Where(x => x.Level == 2 && x.IsDeleted == 0 && x.ArticleId.HasValue && x.ArticleId > 0 &&
            catalogs.Any(p => p.ColumnId == x.ColumnId && p.Id == x.ParentId && p.Level == 1 && p.IsDeleted == 0)).Select(x => x.ArticleId!.Value).Distinct().ToArray(), ct);
    private async Task<ColumnDataModel> RequireAsync(long id, CancellationToken ct) {
        var column = await columnRepository.GetByIdAsync(id, ct);
        Guard.Against(column is null, ErrorCodes.ColumnNotFound, "Column not found.");
        return column!;
    }
    private static void Validate(string title, string summary, string cover) {
        Guard.Against(string.IsNullOrWhiteSpace(title), ErrorCodes.ColumnTitleInvalid, "Column title is required.");
        Guard.Against(string.IsNullOrWhiteSpace(summary), ErrorCodes.ColumnSummaryInvalid, "Column summary is required.");
        Guard.Against(string.IsNullOrWhiteSpace(cover), ErrorCodes.ColumnCoverInvalid, "Column cover is required.");
    }
    private async Task SaveAsync(ColumnDataModel column, CancellationToken ct) {
        await unitOfWork.BeginTransactionAsync(ct);
        try {
            await columnRepository.UpdateAsync(column, ct);
            await unitOfWork.CommitAsync(ct);
        } catch {
            await unitOfWork.RollbackAsync(ct);
            throw;
        }
    }
}
