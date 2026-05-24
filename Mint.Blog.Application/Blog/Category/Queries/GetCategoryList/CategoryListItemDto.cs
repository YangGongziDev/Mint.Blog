namespace Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;

public sealed record CategoryListItemDto(long Id, string Name, int ArticlesTotal, long? Sort, DateTimeOffset CreatedAt,
	short IsDeleted) {
	public DateTimeOffset CreateTime => CreatedAt;
}
