namespace Mint.Blog.Application.Blog.Column.Commands.SetColumnPublish;

public sealed record SetColumnPublishCommand(long ColumnId, bool IsPublish);