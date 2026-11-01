namespace Mint.Blog.Model.Vos;

public sealed record SurferResponse<T>(bool Success, T? Data, string? Message = null) {
    public static SurferResponse<T> Ok(T? data, string? message = null) => new(true, data, message);
}
public sealed record SurferCategoryListItem(long Id, string Name, int ArticlesTotal, long? Sort = 0);
public sealed record SurferTagListItem(long Id, string Name, int ArticlesTotal, long? Sort = 0);
