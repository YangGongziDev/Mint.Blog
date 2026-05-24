namespace Mint.Blog.Application.Blog.Column.Commands.UpdateColumnCatalog;

public sealed record UpdateColumnCatalogItemCommand(
	long Id,
	long ArticleId,
	string Title,
	int Sort,
	int Level,
	IReadOnlyCollection<UpdateColumnCatalogItemCommand> Children);