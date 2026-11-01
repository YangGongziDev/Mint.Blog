using SqlSugar;

namespace Mint.Blog.Repository.Persistence;

public interface ISqlSugarDbContext {
	ISqlSugarClient Client { get; }
}
