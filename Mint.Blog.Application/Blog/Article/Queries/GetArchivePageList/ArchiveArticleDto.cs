namespace Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;

public sealed record ArchiveArticleDto(
	long Id,
	string Cover,
	string Title,
	DateOnly CreatedDate);