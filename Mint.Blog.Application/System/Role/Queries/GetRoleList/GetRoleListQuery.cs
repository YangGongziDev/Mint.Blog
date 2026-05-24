namespace Mint.Blog.Application.System.Role.Queries.GetRoleList;

public sealed record GetRoleListQuery(
    string? UserName,
    string? Role,
    int Current = 1,
    int Size = 10);
