namespace Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;

public sealed record ArchiveMonthGroupDto(
	string Month,
	IReadOnlyCollection<ArchiveArticleDto> Articles);