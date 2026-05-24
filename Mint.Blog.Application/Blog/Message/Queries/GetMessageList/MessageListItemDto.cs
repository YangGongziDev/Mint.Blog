namespace Mint.Blog.Application.Blog.Message.Queries.GetMessageList;

public sealed record MessageListItemDto(
	long Id,
	string Nickname,
	string? Website,
	string Content,
	string Color,
	DateTimeOffset CreatedAt);
