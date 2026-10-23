namespace Mint.Blog.Application.Blog.Article.Queries.GetRssArticles;

public interface IGetRssArticlesQueryService {
	Task<IReadOnlyCollection<RssArticleDto>> GetAsync(CancellationToken cancellationToken = default);
}

public sealed record RssArticleDto(
	long Id, string Title, string Summary, string Content, DateTimeOffset CreatedAt, DateTimeOffset UpdatedAt);
