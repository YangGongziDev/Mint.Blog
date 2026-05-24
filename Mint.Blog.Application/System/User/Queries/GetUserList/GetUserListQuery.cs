namespace Mint.Blog.Application.System.User.Queries.GetUserList;

public sealed record GetUserListQuery(
    string? UserName,
    string? DisplayName,
    int? IsDeleted,
    int Current = 1,
    int Size = 10);
