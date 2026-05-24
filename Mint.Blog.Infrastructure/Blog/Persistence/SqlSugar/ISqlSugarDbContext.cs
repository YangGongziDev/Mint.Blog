using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;

public interface ISqlSugarDbContext {
	ISqlSugarClient Client { get; }
}