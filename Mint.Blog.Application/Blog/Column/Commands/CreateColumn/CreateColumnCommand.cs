namespace Mint.Blog.Application.Blog.Column.Commands.CreateColumn;

public sealed record CreateColumnCommand(
	string Title,
	string Summary,
	string Cover);