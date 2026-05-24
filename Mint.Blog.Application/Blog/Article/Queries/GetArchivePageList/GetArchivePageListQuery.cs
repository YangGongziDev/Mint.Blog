namespace Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;

public sealed record GetArchivePageListQuery(
	int PageNumber = 1,
	int PageSize = 10);