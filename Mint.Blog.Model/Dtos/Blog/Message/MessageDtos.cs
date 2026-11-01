namespace Mint.Blog.Model.Dtos.Blog.Message;

public sealed record GetMessageListRequest(int PageNumber = 1, int PageSize = 10);
public sealed record PublishMessageCommand(string Nickname, string? Email, string? Website, string Content, string Color);
