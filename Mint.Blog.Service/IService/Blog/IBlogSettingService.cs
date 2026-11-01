using Mint.Blog.Model.Dtos.Blog.Setting;
using Mint.Blog.Model.Vos.Blog.Setting;

namespace Mint.Blog.Service.IService.Blog;

public interface IBlogSettingService {
	Task<BlogSettingsDetailVo?> GetAsync(CancellationToken cancellationToken = default);
	Task UpdateAsync(UpdateBlogSettingsDto command, CancellationToken cancellationToken = default);
}
