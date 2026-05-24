namespace Mint.Blog.Application.Blog.Tag.Queries.GetTagList;

public sealed record TagListItemDto(long Id, string Name, int ArticlesTotal, long? Sort, DateTimeOffset CreatedAt, short IsDeleted) {
	public DateTimeOffset CreateTime => CreatedAt;
}
