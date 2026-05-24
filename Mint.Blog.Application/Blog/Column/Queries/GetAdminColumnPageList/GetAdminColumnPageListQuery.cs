namespace Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnPageList;

public sealed record GetAdminColumnPageListQuery(
	int PageNumber = 1,
	int PageSize = 10,
	string? Title = null,
	DateOnly? StartDate = null,
	DateOnly? EndDate = null);