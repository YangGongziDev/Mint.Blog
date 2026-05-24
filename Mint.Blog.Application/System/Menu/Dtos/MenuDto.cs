namespace Mint.Blog.Application.System.Menu.Dtos;

/// <summary>
///     DTO for system menu list item
/// </summary>
public sealed class MenuDto
{
    public long Id { get; init; }
    public long ParentId { get; init; }
    public string MenuType { get; init; } = "2";
    public string MenuName { get; init; } = string.Empty;
    public string RouteName { get; init; } = string.Empty;
    public string RoutePath { get; init; } = string.Empty;
    public string? Component { get; init; }
    public string Icon { get; init; } = string.Empty;
    public string IconType { get; init; } = "1";
    public string CreateBy { get; init; } = string.Empty;
    public string CreateTime { get; init; } = string.Empty;
    public string UpdateBy { get; init; } = string.Empty;
    public string UpdateTime { get; init; } = string.Empty;
    public string Status { get; init; } = "1";
}
