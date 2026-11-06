using System.Text.Json.Serialization;

namespace Mint.Blog.Model.Dtos.Blog.Tag;

[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record CreateTagCommand(string Name, long CategoryId, string? LogoUrl = null);
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record UpdateTagCommand(long TagId, string Name, long CategoryId, string? LogoUrl = null);
public sealed record UpdateTagSortCommand(long TagId, int Sort, string? Move = null);
public sealed record MoveTagSortFirstCommand(long TagId);
public sealed record MoveTagSortLastCommand(long TagId);
public sealed record DeleteTagCommand(long TagId, int DeleteType = 1);
public sealed record DeleteTagRequest(int DeleteType);
public sealed record TagPageListQuery(int PageNumber, int PageSize, string? Keyword = null, string? Name = null,
    DateOnly? StartDate = null, DateOnly? EndDate = null, string? SortOrder = null);
