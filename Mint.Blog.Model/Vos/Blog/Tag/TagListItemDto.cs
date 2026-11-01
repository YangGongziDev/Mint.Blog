namespace Mint.Blog.Model.Vos.Blog.Tag;

public sealed record TagListItemDto(long Id, string Name, int ArticlesTotal, long? Sort,
    DateTimeOffset CreatedAt, short IsDeleted, string LogoUrl, int VersionCount,
    long CategoryId, string CategoryName, bool ShowInNavigation, string NavigationDescription) {
    public DateTimeOffset CreateTime => CreatedAt;
}
