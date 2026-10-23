namespace Mint.Blog.Application.Blog.Friend;

public sealed record FeedMetadata(string? Name, string? Url, string? Description, string? Avatar);

public interface IFeedMetadataReader {
	Task<FeedMetadata> ReadAsync(string url, CancellationToken cancellationToken = default);
}
