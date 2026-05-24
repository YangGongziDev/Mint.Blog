namespace Mint.Blog.Application.System.Role.Dtos;

/// <summary>
///     DTO for sys_user_role list item
/// </summary>
public sealed class RoleDto
{
    public long Id { get; init; }
    public string UserName { get; init; } = string.Empty;
    public string Role { get; init; } = string.Empty;
    public string CreateBy { get; init; } = string.Empty;
    public string CreateTime { get; init; } = string.Empty;
    public string UpdateBy { get; init; } = string.Empty;
    public string UpdateTime { get; init; } = string.Empty;
    public string Status { get; init; } = "1";

    public string RoleName => Role;
    public string RoleCode => Role;
}
