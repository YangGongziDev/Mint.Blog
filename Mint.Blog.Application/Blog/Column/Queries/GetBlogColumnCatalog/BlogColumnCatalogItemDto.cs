namespace Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnCatalog;

public sealed record BlogColumnCatalogItemDto(
	long Id,
	long ArticleId,
	string Title,
	int Level,
	IReadOnlyCollection<BlogColumnCatalogItemDto> Children);