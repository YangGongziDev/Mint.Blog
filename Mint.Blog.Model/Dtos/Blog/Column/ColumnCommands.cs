namespace Mint.Blog.Model.Dtos.Blog.Column;

public sealed record CreateColumnCommand(string Title, string Summary, string Cover);
public sealed record UpdateColumnCommand(long ColumnId, string Title, string Summary, string Cover);
public sealed record DeleteColumnCommand(long ColumnId, int DeleteType = 1);
public sealed record SetColumnPublishCommand(long ColumnId, bool IsPublish);
public sealed record SetColumnTopCommand(long ColumnId, bool IsTop);
public sealed record UpdateColumnSortCommand(long ColumnId, int Sort);
public sealed record UpdateColumnCatalogCommand(long ColumnId, IReadOnlyCollection<UpdateColumnCatalogItemCommand> Catalogs);
public sealed record UpdateColumnCatalogItemCommand(long Id, long ArticleId, string Title, int Sort, int Level,
    bool IsDeleted, IReadOnlyCollection<UpdateColumnCatalogItemCommand> Children);
public sealed record GetAdminColumnPageListQuery(int PageNumber = 1, int PageSize = 10, string? Title = null,
    DateOnly? StartDate = null, DateOnly? EndDate = null, string? SortOrder = null);
public sealed record BlogColumnCatalogQuery(long ColumnId);
public sealed record BlogColumnArticlePreNextQuery(long ColumnId, long ArticleId);
public sealed record DeleteColumnRequest(int DeleteType);
public sealed record SurferColumnCatalogRequest(long? Id);
public sealed record SurferColumnArticlePreNextRequest(long? Id, long ArticleId);
public sealed record ColumnCatalogUpsertModel(string Title, long? ArticleId, int Level, long ParentId, int Sort,
    bool IsDeleted = false);
