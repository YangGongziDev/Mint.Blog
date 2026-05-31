namespace Mint.Blog.Application.Blog.Category.Queries.GetCategoryPageList;

public sealed record CategoryPageListQuery(int PageNumber, int PageSize, string? Keyword = null, string? Name = null,
	DateOnly? StartDate = null, DateOnly? EndDate = null, string? SortOrder = null);
