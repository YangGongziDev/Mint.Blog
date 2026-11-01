namespace Mint.Blog.Model.Vos.Blog.Resource;

public sealed class NavigationTagDto {
    public long Id { get; set; }
    public string Name { get; set; } = "";
    public string LogoUrl { get; set; } = "";
    public bool ShowInNavigation { get; set; }
    public long CategoryId { get; set; }
    public string CategoryName { get; set; } = "";
    public string NavigationDescription { get; set; } = "";
    public long VersionCount { get; set; }
    public long ResourceCount { get; set; }
}
public sealed class TagVersionDto {
    public long Id { get; set; }
    public long TagId { get; set; }
    public string Name { get; set; } = "";
    public long Sort { get; set; }
    public bool IsGeneral { get; set; }
    public long ArticleCount { get; set; }
    public long ResourceCount { get; set; }
}
public class SelectionView {
    public long TagId { get; set; }
    public long TagVersionId { get; set; }
    public long CategoryId { get; set; }
    public string CategoryName { get; set; } = "";
    public string TagName { get; set; } = "";
    public string TagVersionName { get; set; } = "";
    public bool IsGeneral { get; set; }
}
public sealed class ResourceDto : SelectionView {
    public long Id { get; set; }
    public string Title { get; set; } = "";
    public string Description { get; set; } = "";
    public string Url { get; set; } = "";
    public int Kind { get; set; }
    public bool IsFeatured { get; set; }
    public long Sort { get; set; }
    public bool IsDeleted { get; set; }
}
public sealed class NavigationArticleDto : SelectionView {
    public long Id { get; set; }
    public string Title { get; set; } = "";
    public string Summary { get; set; } = "";
    public string Cover { get; set; } = "";
    public DateTimeOffset CreateTime { get; set; }
}
