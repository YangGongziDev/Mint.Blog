namespace Mint.Blog.Application.Blog.Tag.Queries.GetTagPageList;

public sealed record TagPageListQuery(int PageNumber, int PageSize, string? Keyword = null, string? Name = null, DateOnly? StartDate = null,
	DateOnly? EndDate = null, string? SortOrder = null);
