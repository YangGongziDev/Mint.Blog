namespace Mint.Blog.Model.Vos.Blog.Category;

public sealed record CategoryListItemDto(long Id, string Name, int ArticlesTotal, long? Sort,
    DateTimeOffset CreatedAt, short IsDeleted) {
    public DateTimeOffset CreateTime => CreatedAt;
}
