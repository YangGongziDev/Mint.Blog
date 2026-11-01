namespace Mint.Blog.Model.Vos.Blog.Friend;

public sealed record FriendListItemVo(long Id, string Name, string Description, string Url, string Avatar, string Status, DateTimeOffset CreatedAt, string Category, bool IsTop, string Email, int Sort, DateTimeOffset UpdatedAt);
public sealed record FriendDetailVo(long Id, string Name, string Description, string Url, string Avatar, string Status, DateTimeOffset CreatedAt, string Category, bool IsTop, string Email, int Sort, DateTimeOffset UpdatedAt);
public sealed record AdminFriendPageItemVo(long Id, string Name, string Description, string Url, string Avatar, string Status, DateTimeOffset CreatedAt, string Category, bool IsTop, string Email, int Sort, bool IsDeleted, DateTimeOffset UpdatedAt, string? RssUrl = null);
public sealed record FeedMetadata(string? Name, string? Url, string? Description, string? Avatar);
