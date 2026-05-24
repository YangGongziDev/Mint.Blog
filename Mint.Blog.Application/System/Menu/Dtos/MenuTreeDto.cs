namespace Mint.Blog.Application.System.Menu.Dtos;

/// <summary>
///     DTO for menu tree node
/// </summary>
public sealed class MenuTreeDto
{
    public long Id { get; init; }
    public string Label { get; init; } = string.Empty;
    public long PId { get; init; }
    public List<MenuTreeDto> Children { get; init; } = [];
}
