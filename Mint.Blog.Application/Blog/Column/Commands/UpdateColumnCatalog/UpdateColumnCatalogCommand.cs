namespace Mint.Blog.Application.Blog.Column.Commands.UpdateColumnCatalog;

public sealed record UpdateColumnCatalogCommand(
	long ColumnId,
	IReadOnlyCollection<UpdateColumnCatalogItemCommand> Catalogs);