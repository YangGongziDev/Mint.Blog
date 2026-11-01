namespace Mint.Blog.Model.Vos.Blog.Message;

public sealed record MessageListItemVo(long Id, string Nickname, string? Website, string Content, string Color, DateTimeOffset CreatedAt);
