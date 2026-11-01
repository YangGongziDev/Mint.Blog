using System.Text.Json.Serialization;

namespace Mint.Blog.Model.Dtos.Blog.Resource;

[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record SaveTagVersionCommand(string Name, long Sort, long? TagId = null);
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record SaveResourceCommand(string Title, string? Description, string Url, int Kind, long TagId,
    long TagVersionId, bool IsFeatured, long Sort);
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record ConfigureNavigationTagCommand(bool ShowInNavigation, string? NavigationDescription);
public sealed record ResourcePageQuery(int PageNumber = 1, int PageSize = 20, long? TagId = null,
    long? TagVersionId = null, int? Kind = null, string? Keyword = null, bool IsDeleted = false);
public sealed record NavigationArticleQuery(int PageNumber = 1, int PageSize = 20, long? TagVersionId = null, string? Keyword = null);
