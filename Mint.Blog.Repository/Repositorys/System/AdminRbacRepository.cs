using System.Text.Json.Nodes;
using Mint.Blog.Model.Entitys.System;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.System;

public sealed class AdminRbacRepository(ISqlSugarDbContext db) : IAdminRbacRepository {
    private const string PermissionSql = "SELECT json_build_object('id',id::text,'name',CASE WHEN name LIKE '{%' THEN name::json ELSE to_json(name) END,'code',code,'description',description,'resource',resource,'action',action,'type',type,'parentId',parent_id::text,'path',path,'component',component,'icon',icon,'sort',sort,'status',status,'visible',visible)::text FROM sys_permission ORDER BY sort,id";
    private const string RoleSql = "SELECT json_build_object('id',id::text,'name',name,'code',code,'description',description,'createdAt',create_time,'updatedAt',update_time)::text FROM sys_role";
    private const string UserSql = "SELECT json_build_object('id',id::text,'username',username,'realName',display_name,'email',email,'phone',phone,'avatar',avatar,'gender',gender,'birthDate',birth_date,'bio',bio,'status',status,'createdAt',create_time,'updatedAt',update_time)::text FROM sys_user";
    private async Task<List<JsonObject>> Rows(string sql, object? args = null) => (await db.Client.Ado.SqlQueryAsync<string>(sql, args)).Select(x => JsonNode.Parse(x)!.AsObject()).ToList();
    private Task<int> Execute(string sql, object? args = null) => db.Client.Ado.ExecuteCommandAsync(sql, args);
    private static string Text(JsonObject row, string key) => row[key]?.ToString() ?? "";
    private static string IdList(IEnumerable<long> ids) => string.Join(",", ids.DefaultIfEmpty(0));
    public Task LockAsync() => Execute("SELECT pg_advisory_xact_lock(2026101201)");
    public Task<List<JsonObject>> PermissionsAsync() => Rows(PermissionSql);
    public Task<List<JsonObject>> RolesAsync(long? id = null, IReadOnlyCollection<long>? ids = null) => Roles(id.HasValue ? " WHERE id=@id" : ids is not null ? $" WHERE id IN ({IdList(ids)}) ORDER BY id" : " ORDER BY id", new { id });
    private async Task<List<JsonObject>> Roles(string suffix, object? args = null) {
        var roles = await Rows(RoleSql + suffix, args);
        if (roles.Count == 0) return roles;
        var links = await db.Client.Ado.SqlQueryAsync<RolePermissionRow>($"SELECT role_id AS roleid,permission_id AS permissionid FROM sys_role_permission WHERE role_id IN ({IdList(roles.Select(r => long.Parse(Text(r, "id"))))})");
        var permissions = await Rows(PermissionSql.Replace("ORDER BY sort,id", $"WHERE id IN ({IdList(links.Select(l => l.PermissionId).Distinct())}) ORDER BY sort,id"));
        var byRole = links.ToLookup(l => l.RoleId, l => l.PermissionId.ToString());
        var byPermission = permissions.ToDictionary(p => Text(p, "id"));
        foreach (var role in roles) role["permissions"] = new JsonArray(byRole[long.Parse(Text(role, "id"))].Where(byPermission.ContainsKey).Select(i => byPermission[i].DeepClone()).ToArray());
        return roles;
    }
    public Task<List<JsonObject>> UsersAsync(long? id = null) => Users(id.HasValue ? " AND id=@id" : " ORDER BY id", new { id });
    private async Task<List<JsonObject>> Users(string suffix, object? args = null) {
        var users = await Rows(UserSql + " WHERE is_deleted=0" + suffix, args);
        if (users.Count == 0) return users;
        var links = await db.Client.Ado.SqlQueryAsync<UserRoleLink>($"SELECT user_id AS userid,role_id AS roleid FROM sys_user_role WHERE user_id IN ({IdList(users.Select(u => long.Parse(Text(u, "id"))))})");
        var roles = await RolesAsync(ids: links.Select(l => l.RoleId).Distinct().ToArray());
        var byUser = links.ToLookup(l => l.UserId, l => l.RoleId.ToString());
        var byRole = roles.ToDictionary(r => Text(r, "id"));
        foreach (var user in users) {
            var assigned = byUser[long.Parse(Text(user, "id"))].Distinct().Where(byRole.ContainsKey).Select(i => byRole[i]).ToList();
            user["roles"] = new JsonArray(assigned.Select(r => r.DeepClone()).ToArray());
            user["permissions"] = new JsonArray(assigned.SelectMany(r => r["permissions"]!.AsArray()).OfType<JsonObject>().Where(p => Text(p, "status") == "active").DistinctBy(p => Text(p, "id")).Select(p => p.DeepClone()).ToArray());
        }
        return users;
    }
    public async Task<(List<JsonObject> Rows, long Total)> ReadPageAsync(string resource, long? id, IReadOnlyDictionary<string, string> query, int page, int size) {
        var filters = new List<string>();
        var args = new List<SqlSugar.SugarParameter>();
        if (id.HasValue) { filters.Add("id=@id"); args.Add(new("@id", id.Value)); }
        var fields = resource == "users" ? new Dictionary<string, string> { ["username"] = "username", ["realName"] = "display_name", ["email"] = "email", ["phone"] = "phone", ["status"] = "status" } : new Dictionary<string, string> { ["name"] = "name", ["code"] = "code" };
        foreach (var field in fields) if (query.TryGetValue(field.Key, out var value) && !string.IsNullOrWhiteSpace(value)) {
            var parameter = "@filter" + args.Count;
            filters.Add(field.Key == "status" ? $"{field.Value}={parameter}" : $"strpos(lower(coalesce({field.Value},'')),lower({parameter}))>0");
            args.Add(new(parameter, value));
        }
        var condition = filters.Count == 0 ? "" : " AND " + string.Join(" AND ", filters);
        var where = resource == "users" ? " WHERE is_deleted=0" : " WHERE 1=1";
        var total = id.HasValue ? 0 : (await db.Client.Ado.SqlQueryAsync<long>($"SELECT count(*) FROM {(resource == "users" ? "sys_user" : "sys_role")}{where}{condition}", args.ToArray())).Single();
        var suffix = condition + " ORDER BY id";
        if (!id.HasValue) { suffix += " LIMIT @limit OFFSET @offset"; args.Add(new("@limit", size)); args.Add(new("@offset", (page - 1) * size)); }
        var rows = resource == "users" ? await Users(suffix, args.ToArray()) : await Roles(" WHERE 1=1" + suffix, args.ToArray());
        return (rows, total);
    }
    private async Task<bool> Exists(string sql, object args) => (await db.Client.Ado.SqlQueryAsync<long>(sql, args)).Single() > 0;
    private async Task<long> Insert(string sql, object args) => (await db.Client.Ado.SqlQueryAsync<long>(sql, args)).Single();
    public Task<bool> UserNameExistsAsync(string name, long id) => Exists("SELECT count(*) FROM sys_user WHERE username=@name AND id<>@id", new { name, id });
    public Task<bool> RoleCodeExistsAsync(string code, long id) => Exists("SELECT count(*) FROM sys_role WHERE code=@code AND id<>@id", new { code, id });
    public Task<bool> RoleAssignedAsync(long? id) => Exists("SELECT count(*) FROM sys_user_role WHERE role_id=@id", new { id });
    public async Task DeleteUserAsync(long? id) {
        await Execute("DELETE FROM sys_user_role WHERE user_id=@id", new { id });
        await Execute("UPDATE sys_user SET is_deleted=1,update_time=now() WHERE id=@id", new { id });
    }
    public Task RevokeAsync(long id) => Execute("UPDATE sys_user_refresh_token SET is_revoked=1,revoked_at=now() WHERE user_id=@id AND is_revoked=0", new { id });
    public Task<long> InsertUserAsync(object values) => Insert("INSERT INTO sys_user(username,display_name,password,email,phone,avatar,gender,birth_date,bio,status) VALUES(@username,@realName,@password,@email,@phone,@avatar,@gender,@birthDate,@bio,@status) RETURNING id", values);
    public Task UpdateUserAsync(object values) => Execute("UPDATE sys_user SET display_name=@realName,email=@email,phone=@phone,avatar=@avatar,gender=@gender,birth_date=@birthDate,bio=@bio,status=@status,update_time=now() WHERE id=@id", values);
    public async Task ReplaceUserRolesAsync(long? id, IEnumerable<long> ids) {
        await Execute("DELETE FROM sys_user_role WHERE user_id=@id", new { id });
        foreach (var roleId in ids) await Execute("INSERT INTO sys_user_role(user_id,role_id,username,role) SELECT @id,r.id,u.username,r.code FROM sys_role r CROSS JOIN sys_user u WHERE r.id=@roleId AND u.id=@id", new { id, roleId });
    }
    public Task DeleteRoleAsync(long? id) => Execute("DELETE FROM sys_role WHERE id=@id", new { id });
    public Task<long> InsertRoleAsync(string name, string code, string description) => Insert("INSERT INTO sys_role(name,code,description) VALUES(@name,@code,@description) RETURNING id", new { name, code, description });
    public Task UpdateRoleAsync(long? id, string name, string description) => Execute("UPDATE sys_role SET name=@name,description=@description,update_time=now() WHERE id=@id", new { id, name, description });
    public async Task ReplaceRolePermissionsAsync(long? id, IEnumerable<long> ids) {
        await Execute("DELETE FROM sys_role_permission WHERE role_id=@id", new { id });
        foreach (var permissionId in ids) await Execute("INSERT INTO sys_role_permission(role_id,permission_id) VALUES(@id,@permissionId)", new { id, permissionId });
    }
    public Task DeletePermissionAsync(long? id) => Execute("DELETE FROM sys_permission WHERE id=@id", new { id });
    public Task<long> InsertPermissionAsync(object values) => Insert("INSERT INTO sys_permission(name,code,description,resource,action,type,parent_id,path,component,icon,sort,status,visible) VALUES(@name,@code,@description,@resource,@action,@type,CAST(@parent AS bigint),@path,@component,@icon,@sort,@status,@visible) RETURNING id", values);
    public Task UpdatePermissionAsync(object values) => Execute("UPDATE sys_permission SET name=@name,description=@description,resource=@resource,action=@action,type=@type,parent_id=CAST(@parent AS bigint),path=@path,component=@component,icon=@icon,sort=@sort,status=@status,visible=@visible WHERE id=@id", values);
}
