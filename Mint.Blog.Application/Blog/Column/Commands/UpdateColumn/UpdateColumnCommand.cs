namespace Mint.Blog.Application.Blog.Column.Commands.UpdateColumn;

public sealed record UpdateColumnCommand(
	long ColumnId,
	string Title,
	string Summary,
	string Cover);