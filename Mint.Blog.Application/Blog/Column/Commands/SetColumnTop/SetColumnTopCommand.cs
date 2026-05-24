namespace Mint.Blog.Application.Blog.Column.Commands.SetColumnTop;

public sealed record SetColumnTopCommand(long ColumnId, bool IsTop);