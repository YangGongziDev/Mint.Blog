namespace Mint.Blog.Application.Blog.Column.Commands.DeleteColumn;

public sealed record DeleteColumnCommand(long ColumnId, int DeleteType = 1);