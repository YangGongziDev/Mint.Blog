namespace Mint.Blog.Model.Dtos.Blog.Category;

public sealed record CreateCategoryCommand(string Name);
public sealed record UpdateCategoryCommand(long CategoryId, string Name);
public sealed record UpdateCategorySortCommand(long CategoryId, int Sort);
public sealed record MoveCategorySortFirstCommand(long CategoryId);
public sealed record MoveCategorySortLastCommand(long CategoryId);
public sealed record DeleteCategoryCommand(long CategoryId, int DeleteType = 1);
public sealed record DeleteCategoryRequest(int DeleteType);
public sealed record CategoryPageListQuery(int PageNumber, int PageSize, string? Keyword = null, string? Name = null,
    DateOnly? StartDate = null, DateOnly? EndDate = null, string? SortOrder = null);
