namespace Mint.Blog.Application.Blog.Setting.Queries.GetBlogSettingsDetail;

public interface IGetBlogSettingsDetailQueryService {
	Task<BlogSettingsDetailDto?> GetAsync(CancellationToken cancellationToken = default);
}