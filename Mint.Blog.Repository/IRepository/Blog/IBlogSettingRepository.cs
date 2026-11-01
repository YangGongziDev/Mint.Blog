using Mint.Blog.Model.Entitys.Blog.Setting;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IBlogSettingRepository {
	Task<BlogSettingDataModel?> GetAsync(CancellationToken cancellationToken = default);
	Task SaveAsync(BlogSettingDataModel setting, CancellationToken cancellationToken = default);
}
