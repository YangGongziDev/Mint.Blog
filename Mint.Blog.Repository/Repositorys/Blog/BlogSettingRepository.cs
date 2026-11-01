using Mint.Blog.Model.Entitys.Blog.Setting;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class BlogSettingRepository(ISqlSugarDbContext dbContext) : IBlogSettingRepository {
	public async Task<BlogSettingDataModel?> GetAsync(CancellationToken cancellationToken = default) =>
		await dbContext.Client.Queryable<BlogSettingDataModel>().Where(x => x.Id == 1).SingleAsync();

	public async Task SaveAsync(BlogSettingDataModel setting, CancellationToken cancellationToken = default){
		var exists = await dbContext.Client.Queryable<BlogSettingDataModel>().AnyAsync(x => x.Id == setting.Id);
		if (exists) {
			await dbContext.Client.Updateable(setting).ExecuteCommandAsync();
			return;
		}
		await dbContext.Client.Insertable(setting).ExecuteCommandAsync();
	}
}
