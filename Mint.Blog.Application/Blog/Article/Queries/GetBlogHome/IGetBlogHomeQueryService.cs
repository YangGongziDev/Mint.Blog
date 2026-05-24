namespace Mint.Blog.Application.Blog.Article.Queries.GetBlogHome;

public interface IGetBlogHomeQueryService {
	Task<BlogHomeDto> GetAsync(BlogHomeQuery query, CancellationToken cancellationToken = default);
}