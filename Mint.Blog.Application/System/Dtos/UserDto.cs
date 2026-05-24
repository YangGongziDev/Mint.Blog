namespace Mint.Blog.Application.System.Dtos;

/// <summary>
///     DTO for sys_user list item
/// </summary>
public sealed class UserDto
{
    public long Id { get; init; }
    public string UserName { get; init; } = string.Empty;
    public string DisplayName { get; init; } = string.Empty;
    public int IsDeleted { get; init; }
    public string CreateBy { get; init; } = string.Empty;
    public string CreateTime { get; init; } = string.Empty;
    public string UpdateBy { get; init; } = string.Empty;
    public string UpdateTime { get; init; } = string.Empty;
    public string Status { get; init; } = "1";
}
