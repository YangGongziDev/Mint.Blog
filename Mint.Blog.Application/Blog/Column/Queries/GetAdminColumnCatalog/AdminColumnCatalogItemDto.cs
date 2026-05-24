namespace Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnCatalog;

public sealed record AdminColumnCatalogItemDto(
	long Id,
	long ArticleId,
	string Title,
	int Sort,
	int Level,
	bool IsDeleted,
	bool Editing,
	IReadOnlyCollection<AdminColumnCatalogItemDto> Children);