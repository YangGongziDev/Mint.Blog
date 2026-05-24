namespace Mint.Blog.Application.Blog.Comment.Queries.GetAdminCommentPageList;

public sealed record GetAdminCommentPageListQuery(
	int PageNumber,
	int PageSize,
	string? RouterUrl,
	DateOnly? StartDate,
	DateOnly? EndDate,
	int? Status);