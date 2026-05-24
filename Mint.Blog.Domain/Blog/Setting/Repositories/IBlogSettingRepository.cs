using Mint.Blog.Domain.Blog.Setting.Entities;

namespace Mint.Blog.Domain.Blog.Setting.Repositories;

public interface IBlogSettingRepository {
	Task<BlogSetting?> GetAsync(CancellationToken cancellationToken = default);
	Task SaveAsync(BlogSetting setting, CancellationToken cancellationToken = default);
}