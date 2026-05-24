namespace Mint.Blog.Application.Blog.Message.Commands.PublishMessage;

public sealed record PublishMessageCommand(
	string Nickname,
	string? Email,
	string? Website,
	string Content,
	string Color);
