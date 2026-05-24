namespace Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnArticlePreNext;

public interface IGetBlogColumnArticlePreNextQueryService {
	Task<BlogColumnArticlePreNextDto> GetAsync(BlogColumnArticlePreNextQuery query,
		CancellationToken cancellationToken = default);
}