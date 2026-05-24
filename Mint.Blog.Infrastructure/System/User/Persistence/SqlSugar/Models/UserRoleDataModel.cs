using SqlSugar;

namespace Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;

[SugarTable("sys_user_role")]
public sealed class UserRoleDataModel
{
    [SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
    public long Id { get; set; }

    [SugarColumn(ColumnName = "username")]
    public string UserName { get; set; } = string.Empty;

    [SugarColumn(ColumnName = "role")]
    public string Role { get; set; } = string.Empty;

    [SugarColumn(ColumnName = "create_time")]
    public DateTimeOffset CreatedAt { get; set; }
}
