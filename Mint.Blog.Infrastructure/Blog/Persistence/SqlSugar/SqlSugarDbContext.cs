using Microsoft.Extensions.Options;
using Mint.Blog.Infrastructure.Options;
using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;

public sealed class SqlSugarDbContext : ISqlSugarDbContext {
	public SqlSugarDbContext(IOptions<PostgreSqlOptions> options){
		Client = new SqlSugarClient(new ConnectionConfig {
			ConnectionString = options.Value.ConnectionString,
			DbType = DbType.PostgreSQL,
			IsAutoCloseConnection = true,
			InitKeyType = InitKeyType.Attribute
		});
	}

	public ISqlSugarClient Client { get; }
}