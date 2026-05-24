namespace Mint.Blog.Application.System.User.Queries.GetSystemUserInfo;

public sealed record SystemUserInfoDto(
    string UserId,
    string UserName,
    string DisplayName,
    IReadOnlyCollection<string> Roles,
    IReadOnlyCollection<string> Buttons);
