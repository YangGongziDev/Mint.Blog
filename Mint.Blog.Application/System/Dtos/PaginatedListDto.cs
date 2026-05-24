namespace Mint.Blog.Application.System.Dtos;

/// <summary>
///     DTO for paginated list response
/// </summary>
public sealed class PaginatedListDto<T>
{
    public int Current { get; init; } = 1;
    public int Size { get; init; } = 10;
    public int Total { get; init; }
    public List<T> Records { get; init; } = [];
}
