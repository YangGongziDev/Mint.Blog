using System.Text.Json.Serialization;

namespace Mint.Blog.Model.Dtos.Blog.Article;

[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record CreateArticleCommand(string Title, string Summary, string Content, string Cover, long TagId, long TagVersionId, short Visibility);
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record UpdateArticleCommand(long ArticleId, string Title, string Summary, string Content, string Cover, long TagId, long TagVersionId, short Visibility);
public sealed record DeleteArticleCommand(long ArticleId, long DeleteType);
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record PatchArticleCommand {
    private bool? _isTop;
    private short? _visibility;
    [JsonIgnore] public long ArticleId { get; init; }
    public bool? IsTop { get => _isTop; init { _isTop = value; HasIsTop = true; } }
    public short? Visibility { get => _visibility; init { _visibility = value; HasVisibility = true; } }
    [JsonIgnore] public bool HasIsTop { get; private init; }
    [JsonIgnore] public bool HasVisibility { get; private init; }
}
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record SaveArticleDraftCommand(string? DraftId, string? ArticleId, string? Title, string? Summary,
    string? Content, string? Cover, [property: JsonRequired] long? TagId,
    [property: JsonRequired] long? TagVersionId, short Visibility);
public sealed record ArticleListQuery(int PageNumber, int PageSize, long? CategoryId = null, long? TagId = null,
    string? Title = null, DateOnly? StartDate = null, DateOnly? EndDate = null,
    string? SortOrder = null, bool IncludeColumnOnly = false, long? TagVersionId = null);
public sealed record ArticleDetailQuery(long ArticleId, long? ColumnId = null, bool ForAdmin = false);
public sealed record SearchArticlesQuery(string Keyword, int PageNumber, int PageSize);
public interface IArticlePageRequest {
    int Current { get; }
    int Size { get; }
    long? TagVersionId { get; }
}
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record SurferArticlePageRequest(int Current = 1, int Size = 10, long? CategoryId = null, long? TagId = null, long? TagVersionId = null) : IArticlePageRequest;
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public sealed record SurferScopedArticlePageRequest(int Current = 1, int Size = 10, long? Id = null,
    long? CategoryId = null, long? TagId = null, long? TagVersionId = null) : IArticlePageRequest {
    public long? ScopedId => Id ?? CategoryId ?? TagId;
}
public sealed record SurferArticleDetailRequest(string? ArticleId, long? ColumnId = null);
