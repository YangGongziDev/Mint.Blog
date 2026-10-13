using System.Text.Json.Nodes;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Auth;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;

namespace Mint.Blog.Infrastructure.System.Auth;

public sealed class AdminRbacService(ISqlSugarDbContext db, IAdminIdentityQuery identities, IPasswordHasher passwords) : IAdminRbacService {
	private const string PermissionSql = "SELECT json_build_object('id',id::text,'name',CASE WHEN name LIKE '{%' THEN name::json ELSE to_json(name) END,'code',code,'description',description,'resource',resource,'action',action,'type',type,'parentId',parent_id::text,'path',path,'component',component,'icon',icon,'sort',sort,'status',status,'visible',visible)::text FROM sys_permission ORDER BY sort,id";
	private async Task<List<JsonObject>> Rows(string sql, object? args = null) => (await db.Client.Ado.SqlQueryAsync<string>(sql, args)).Select(x => JsonNode.Parse(x)!.AsObject()).ToList();
	private Task<int> Execute(string sql, object? args = null) => db.Client.Ado.ExecuteCommandAsync(sql, args);
	private static BusinessException Invalid(string message) => new("VALIDATION_ERROR", message);
	private static BusinessException Forbidden(string message) => new(ErrorCodes.Forbidden, message);
	private static string Text(JsonObject input, string key, string fallback = "") => input[key] is null ? fallback : input[key] is JsonValue value && value.TryGetValue<string>(out var text) ? text : throw Invalid($"{key} 必须是字符串");
	private static long Id(string value) => long.TryParse(value, global::System.Globalization.NumberStyles.None, global::System.Globalization.CultureInfo.InvariantCulture, out var id) && id > 0 ? id : throw Invalid("无效的 ID");
	private static HashSet<long> Ids(JsonObject input, string key){
		if (input[key] is not JsonArray values) throw Invalid($"{key} 必须是 ID 数组");
		return values.Select(x => x is JsonValue ? Id(x.ToString()) : throw Invalid("无效的 ID")).ToHashSet();
	}
	private static string Required(JsonObject input, string key, int max = 150){
		var value = Text(input, key).Trim();
		if (value.Length == 0 || value.Length > max) throw Invalid($"{key} 必填且不得超过 {max} 字符");
		return value;
	}
	private static string Status(JsonObject input){
		var value = Text(input, "status", "active");
		return value is "active" or "inactive" ? value : throw Invalid("无效状态");
	}
	private async Task<List<JsonObject>> Permissions() => await Rows(PermissionSql);
	private const string RoleSql = "SELECT json_build_object('id',id::text,'name',name,'code',code,'description',description,'createdAt',create_time,'updatedAt',update_time)::text FROM sys_role";
	private const string UserSql = "SELECT json_build_object('id',id::text,'username',username,'realName',display_name,'email',email,'phone',phone,'avatar',avatar,'gender',gender,'birthDate',birth_date,'bio',bio,'status',status,'createdAt',create_time,'updatedAt',update_time)::text FROM sys_user";
	private static string IdList(IEnumerable<long> ids) => string.Join(",", ids.DefaultIfEmpty(0));
	private async Task<List<JsonObject>> Roles(string suffix = " ORDER BY id", object? args = null){
		var roles = await Rows(RoleSql + suffix, args);
		if (roles.Count == 0) return roles;
		var roleIds = IdList(roles.Select(r => Id(Text(r, "id"))));
		var links = await db.Client.Ado.SqlQueryAsync<AdminIdentityQuery.RolePermissionRow>($"SELECT role_id AS roleid,permission_id AS permissionid FROM sys_role_permission WHERE role_id IN ({roleIds})");
		var permissionIds = IdList(links.Select(l => l.PermissionId).Distinct());
		var permissions = await Rows(PermissionSql.Replace("ORDER BY sort,id", $"WHERE id IN ({permissionIds}) ORDER BY sort,id"));
		var byRole = links.ToLookup(l => l.RoleId, l => l.PermissionId.ToString());
		var byPermission = permissions.ToDictionary(p => Text(p, "id"));
		foreach (var role in roles) role["permissions"] = new JsonArray(byRole[Id(Text(role, "id"))].Where(byPermission.ContainsKey).Select(i => byPermission[i].DeepClone()).ToArray());
		return roles;
	}
	private async Task<List<JsonObject>> Users(string suffix, object? args = null){
		var users = await Rows(UserSql + " WHERE is_deleted=0" + suffix, args);
		if (users.Count == 0) return users;
		var userIds = IdList(users.Select(u => Id(Text(u, "id"))));
		var links = await db.Client.Ado.SqlQueryAsync<UserRoleLink>($"SELECT user_id AS userid,role_id AS roleid FROM sys_user_role WHERE user_id IN ({userIds})");
		var roles = await Roles($" WHERE id IN ({IdList(links.Select(l => l.RoleId).Distinct())}) ORDER BY id");
		var byUser = links.ToLookup(l => l.UserId, l => l.RoleId.ToString());
		var byRole = roles.ToDictionary(r => Text(r, "id"));
		foreach (var user in users){
			var assigned = byUser[Id(Text(user, "id"))].Distinct().Where(byRole.ContainsKey).Select(i => byRole[i]).ToList();
			user["roles"] = new JsonArray(assigned.Select(r => r.DeepClone()).ToArray());
			user["permissions"] = new JsonArray(assigned.SelectMany(r => r["permissions"]!.AsArray()).OfType<JsonObject>().Where(p => Text(p, "status") == "active").DistinctBy(p => Text(p, "id")).Select(p => p.DeepClone()).ToArray());
		}
		return users;
	}
	public static JsonArray Tree(List<JsonObject> rows, string? parent = null, HashSet<string>? ancestors = null){
		ancestors ??= [];
		var result = new JsonArray();
		foreach (var row in rows.Where(r => (r["parentId"]?.ToString()) == parent)){
			var id = Text(row, "id");
			if (!ancestors.Add(id)) throw Invalid("树中存在循环关联");
			var node = (JsonObject)row.DeepClone();
			node["children"] = Tree(rows, id, ancestors);
			ancestors.Remove(id);
			result.Add(node);
		}
		return result;
	}
	public async Task<object> AssignableAsync(string resource, string username){
		var actor = await identities.GetAsync(username) ?? throw Forbidden("账号已禁用");
		var super = actor.Permissions.Any(p => p.Code == "*");
		var entity = resource switch { "users" => "user", "roles" => "role", _ => throw Invalid("无效资源") };
		if (!super && !actor.Permissions.Any(p => p.Code == $"system.{entity}.add" || p.Code == $"system.{entity}.edit")) throw Forbidden("无操作权限");
		if (resource == "users") return (await Roles()).Where(r => super ||
			(Text(r, "code") is not ("ROLE_ADMIN" or "ROLE_SUPER") && r["permissions"]!.AsArray().OfType<JsonObject>().All(p => InScope(p, actor)))).ToList();
		var permissions = await Permissions();
		var allowed = permissions.Where(p => Text(p, "status") == "active" && (super || InScope(p, actor))).Select(p => Text(p, "id")).ToHashSet();
		// 缺失的祖先不作为可授权节点返回，子节点提升为根节点以保留完整可选范围。
		var rows = permissions.Where(p => allowed.Contains(Text(p, "id"))).ToList();
		foreach (var row in rows) if (row["parentId"] is not null && !allowed.Contains(Text(row, "parentId"))) row["parentId"] = null;
		return Tree(rows);
	}
	private static bool InScope(JsonObject permission, AdminUser actor) => Text(permission, "status") == "active" && Text(permission, "code") != "*" && actor.Permissions.Any(a => a.Id == Text(permission, "id") && a.Code == Text(permission, "code"));
	private async Task<object> ReadPage(string resource, long? id, IReadOnlyDictionary<string, string> query){
		var page = (query.TryGetValue("current", out var p) || query.TryGetValue("page", out p)) && int.TryParse(p, out var pn) ? Math.Clamp(pn, 1, 1000000) : 1;
		var size = query.TryGetValue("pageSize", out var s) && int.TryParse(s, out var sn) ? Math.Clamp(sn, 1, 1000) : 10;
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
		if (id.HasValue) return rows.SingleOrDefault() ?? throw Invalid("记录不存在");
		return new { list = rows, total, current = page, pageSize = size };
	}
	public async Task<object> ReadAsync(string resource, long? id, IReadOnlyDictionary<string, string> query){
		if (resource is "users" or "roles") return await ReadPage(resource, id, query);
		var rows = resource == "permissions" ? await Permissions() : throw Invalid("无效资源");
		if (id.HasValue) return rows.SingleOrDefault(r => Text(r, "id") == id.ToString()) ?? throw Invalid("记录不存在");
		var allRows = rows;
		foreach (var key in new[] { "username", "realName", "email", "phone", "status", "name", "code", "type", "resource" })
			if (query.TryGetValue(key, out var value) && !string.IsNullOrWhiteSpace(value)) rows = rows.Where(r => key is "status" or "type"
				? string.Equals(r[key]?.ToString(), value, StringComparison.Ordinal)
				: (r[key]?.ToString() ?? "").Contains(value, StringComparison.OrdinalIgnoreCase)).ToList();
		if (query.TryGetValue("keyword", out var keyword) && !string.IsNullOrWhiteSpace(keyword))
			rows = rows.Where(r => new[] { "name", "code", "description", "resource", "path" }.Any(key => (r[key]?.ToString() ?? "").Contains(keyword.Trim(), StringComparison.OrdinalIgnoreCase))).ToList();
		var byId = allRows.ToDictionary(r => Text(r, "id"));
		var included = rows.Select(r => Text(r, "id")).ToHashSet();
		foreach (var row in rows){
			var parent = row["parentId"]?.ToString();
			while (parent is not null && byId.TryGetValue(parent, out var ancestor) && included.Add(parent)) parent = ancestor["parentId"]?.ToString();
		}
		return Tree(allRows.Where(r => included.Contains(Text(r, "id"))).ToList());
	}
	public async Task<object?> WriteAsync(string resource, long? id, JsonObject? input, string username, bool delete = false){
		input ??= new JsonObject();
		if (!delete){
			if (resource == "users" && input.ContainsKey("roleIds")) _ = Ids(input, "roleIds");
			if (resource == "roles" && input.ContainsKey("permissionIds")) _ = Ids(input, "permissionIds");
		}
		await db.Client.Ado.BeginTranAsync();
		try {
			// 所有 RBAC 写入串行化：验证与关联替换使用同一事务快照。
			await Execute("SELECT pg_advisory_xact_lock(2026101201)");
			var actor = await identities.GetAsync(username) ?? throw Forbidden("账号已禁用");
			var super = actor.Permissions.Any(p => p.Code == "*");
			var action = delete ? "delete" : id.HasValue ? "edit" : "add";
			var entity = resource switch { "users" => "user", "roles" => "role", "permissions" => "permission", _ => throw Invalid("无效资源") };
			if (!super && !actor.Permissions.Any(p => p.Code == $"system.{entity}.{action}")) throw Forbidden("无操作权限");
			if (resource == "permissions") {
				if (!super) throw Forbidden("仅拥有所有权限的管理员可修改权限定义");
				id = await SavePermission(id, input, delete);
			} else if (resource == "roles") id = await SaveRole(id, input, actor, super, delete);
			else id = await SaveUser(id, input, actor, super, delete);
			await db.Client.Ado.CommitTranAsync();
		} catch {
			await db.Client.Ado.RollbackTranAsync();
			throw;
		}
		return delete ? null : await ReadAsync(resource, id, new Dictionary<string, string>());
	}
	private static void CheckScope(IEnumerable<JsonObject> permissions, AdminUser actor, bool super){
		if (!super && permissions.Any(p => !InScope(p, actor))) throw Forbidden("不能管理或分配超出自身权限的角色");
	}
	private async Task<long?> SaveUser(long? id, JsonObject input, AdminUser actor, bool super, bool delete){
		var old = id.HasValue ? (await Users(" AND id=@id", new { id })).SingleOrDefault() ?? throw Invalid("用户不存在") : null;
		var oldPermissions = old?["roles"]!.AsArray().OfType<JsonObject>().SelectMany(r => r["permissions"]!.AsArray()).OfType<JsonObject>().ToList() ?? [];
		if (old is not null && id?.ToString() != actor.Id) CheckScope(oldPermissions.Where(p => Text(p, "status") == "active"), actor, super);
		HashSet<long>? selected = input.ContainsKey("roleIds") ? Ids(input, "roleIds") : null;
		if (input.ContainsKey("roles") && selected is null) throw Invalid("请使用 roleIds 分配角色");
		var oldRoleIds = old?["roles"]!.AsArray().OfType<JsonObject>().Select(r => Id(Text(r, "id"))).ToHashSet() ?? [];
		var rolesChanged = selected is not null && !selected.SetEquals(oldRoleIds);
		if (id?.ToString() == actor.Id && (delete || rolesChanged || Text(input, "status", "active") != "active")) throw Forbidden("不能删除、禁用自己或修改自己的角色");
		if (delete){
			await Execute("DELETE FROM sys_user_role WHERE user_id=@id", new { id });
			await Execute("UPDATE sys_user SET is_deleted=1,update_time=now() WHERE id=@id", new { id });
			await Revoke(id!.Value);
			return id;
		}
		if (rolesChanged){
			var assigned = await Roles($" WHERE id IN ({IdList(selected!)}) ORDER BY id");
			if (assigned.Count != selected!.Count) throw Invalid("包含不存在的角色");
			var assignedPermissions = assigned.SelectMany(r => r["permissions"]!.AsArray()).OfType<JsonObject>().ToList();
			if (!super && oldPermissions.Any(p => Text(p, "status") != "active") && assignedPermissions.Any(p => Text(p, "status") == "active" && !oldPermissions.Any(o => Text(o, "id") == Text(p, "id")))) throw Forbidden("清理失效关联时不能授予新的有效权限");
			CheckScope(assigned.Where(r => !oldRoleIds.Contains(Id(Text(r, "id")))).SelectMany(r => r["permissions"]!.AsArray()).OfType<JsonObject>(), actor, super);
			if (!super && assigned.Any(r => Text(r, "code") is "ROLE_ADMIN" or "ROLE_SUPER")) throw Forbidden("不能分配系统管理员角色");
		}
		var merged = old is null ? input : (JsonObject)old.DeepClone();
		if (old is not null) foreach (var field in input) merged[field.Key] = field.Value?.DeepClone();
		var name = Required(merged, "username", 60);
		if (old is not null && name != Text(old, "username")) throw Invalid("用户名不可修改");
		if ((await db.Client.Ado.SqlQueryAsync<long>("SELECT count(*) FROM sys_user WHERE username=@name AND id<>@id", new { name, id = id ?? 0L })).Single() > 0) throw Invalid("用户名已存在");
		var args = new { id, username = name, realName = Required(merged, "realName", 100), email = Text(merged, "email"), phone = Text(merged, "phone"), avatar = Text(merged, "avatar"), gender = Text(merged, "gender"), birthDate = Text(merged, "birthDate"), bio = Text(merged, "bio"), status = Status(merged) };
		if (old is null){
			var password = Text(input, "password");
			if (password.Length < 8 || global::System.Text.Encoding.UTF8.GetByteCount(password) > 72) throw Invalid("密码至少 8 字符且不超过 72 字节");
			id = (await db.Client.Ado.SqlQueryAsync<long>("INSERT INTO sys_user(username,display_name,password,email,phone,avatar,gender,birth_date,bio,status) VALUES(@username,@realName,@password,@email,@phone,@avatar,@gender,@birthDate,@bio,@status) RETURNING id", new { args.username, args.realName, password = passwords.Hash(password).Value, args.email, args.phone, args.avatar, args.gender, args.birthDate, args.bio, args.status })).Single();
		} else {
			if (input.ContainsKey("password")) throw Invalid("请使用改密接口修改密码");
			await Execute("UPDATE sys_user SET display_name=@realName,email=@email,phone=@phone,avatar=@avatar,gender=@gender,birth_date=@birthDate,bio=@bio,status=@status,update_time=now() WHERE id=@id", args);
		}
		if (rolesChanged){
			await Execute("DELETE FROM sys_user_role WHERE user_id=@id", new { id });
			foreach (var roleId in selected!) await Execute("INSERT INTO sys_user_role(user_id,role_id,username,role) SELECT @id,r.id,u.username,r.code FROM sys_role r CROSS JOIN sys_user u WHERE r.id=@roleId AND u.id=@id", new { id, roleId });
		}
		if (old is not null && (rolesChanged || args.status != "active")) await Revoke(id!.Value);
		return id;
	}
	private Task<int> Revoke(long id) => Execute("UPDATE sys_user_refresh_token SET is_revoked=1,revoked_at=now() WHERE user_id=@id AND is_revoked=0", new { id });
	private async Task<long?> SaveRole(long? id, JsonObject input, AdminUser actor, bool super, bool delete){
		var old = id.HasValue ? (await Roles(" WHERE id=@id", new { id })).SingleOrDefault() ?? throw Invalid("角色不存在") : null;
		var oldPermissions = old?["permissions"]!.AsArray().OfType<JsonObject>().ToList() ?? [];
		if (old is not null){
			if (Text(old, "code") is "ROLE_SUPER" or "ROLE_ADMIN") throw Forbidden("系统内置角色不可修改或删除");
			if (actor.Roles.Any(r => r.Id == id.ToString())) throw Forbidden("不能修改或删除自己持有的角色");
			CheckScope(oldPermissions.Where(p => Text(p, "status") == "active"), actor, super);
		}
		if (delete){
			if ((await db.Client.Ado.SqlQueryAsync<long>("SELECT count(*) FROM sys_user_role WHERE role_id=@id", new { id })).Single() > 0) throw Invalid("角色已分配给用户，请先解除关联");
			await Execute("DELETE FROM sys_role WHERE id=@id", new { id });
			return id;
		}
		var code = Required(input, "code", 60);
		if (code is "ROLE_SUPER" or "ROLE_ADMIN" || (old is not null && code != Text(old, "code"))) throw Invalid("角色编码不可修改或使用内置编码");
		if ((await db.Client.Ado.SqlQueryAsync<long>("SELECT count(*) FROM sys_role WHERE code=@code AND id<>@id", new { code, id = id ?? 0L })).Single() > 0) throw Invalid("角色编码重复");
		var permissions = await Permissions();
		var selected = input.ContainsKey("permissionIds") ? Ids(input, "permissionIds") : old is null ? [] : old["permissions"]!.AsArray().OfType<JsonObject>().Select(p => Id(Text(p, "id"))).ToHashSet();
		if (selected.Any(i => !permissions.Any(p => Text(p, "id") == i.ToString()))) throw Invalid("包含不存在的权限");
		var previousIds = oldPermissions.Select(p => Id(Text(p, "id"))).ToHashSet();
		var cleaning = !super && oldPermissions.Any(p => Text(p, "status") != "active");
		if (cleaning && !selected.IsSubsetOf(previousIds)) throw Forbidden("清理失效关联时不能授予新的权限");
		CheckScope(permissions.Where(p => selected.Contains(Id(Text(p, "id"))) && !(Text(p, "status") != "active" && previousIds.Contains(Id(Text(p, "id"))))), actor, super);
		if (input.ContainsKey("permissionIds") && !cleaning){
			// 只展开操作者可分配的有效后代；显式提交的越权父节点已在上方拒绝。
			bool changed;
			do { changed = false; foreach (var p in permissions) if (Text(p, "status") == "active" && (super || InScope(p, actor)) && p["parentId"] is not null && selected.Contains(Id(Text(p, "parentId")))) changed |= selected.Add(Id(Text(p, "id"))); } while (changed);
		}
		var name = Required(input, "name", 100);
		var description = Text(input, "description");
		if (old is null) id = (await db.Client.Ado.SqlQueryAsync<long>("INSERT INTO sys_role(name,code,description) VALUES(@name,@code,@description) RETURNING id", new { name, code, description })).Single();
		else await Execute("UPDATE sys_role SET name=@name,description=@description,update_time=now() WHERE id=@id", new { id, name, description });
		if (input.ContainsKey("permissionIds")){
			await Execute("DELETE FROM sys_role_permission WHERE role_id=@id", new { id });
			foreach (var permissionId in selected) await Execute("INSERT INTO sys_role_permission(role_id,permission_id) VALUES(@id,@permissionId)", new { id, permissionId });
		}
		return id;
	}
	private async Task<long?> SavePermission(long? id, JsonObject input, bool delete){
		var rows = await Permissions();
		var old = id.HasValue ? rows.SingleOrDefault(r => Text(r, "id") == id.ToString()) ?? throw Invalid("权限不存在") : null;
		if (old is not null && Text(old, "code") == "*") throw Forbidden("所有权限定义不可修改或删除");
		if (delete){
			if (rows.Any(r => r["parentId"]?.ToString() == id.ToString())) throw Invalid("请先删除子权限");
			await Execute("DELETE FROM sys_permission WHERE id=@id", new { id });
			return id;
		}
		var code = Required(input, "code");
		if (code == "*" || rows.Any(r => Text(r, "code") == code && Text(r, "id") != id?.ToString())) throw Invalid("权限编码重复或保留");
		if (old is not null && code != Text(old, "code")) throw Invalid("权限编码不可修改");
		var parent = string.IsNullOrEmpty(Text(input, "parentId")) ? (long?)null : Id(Text(input, "parentId"));
		var seen = new HashSet<long>();
		var cursor = parent;
		while (cursor.HasValue){
			if (cursor == id || !seen.Add(cursor.Value)) throw Invalid("不能形成循环父子关系");
			var row = rows.SingleOrDefault(r => Text(r, "id") == cursor.ToString()) ?? throw Invalid("父权限不存在");
			cursor = row["parentId"] is null ? null : Id(Text(row, "parentId"));
		}
		var type = Text(input, "type", "menu");
		if (type is not ("menu" or "button" or "api")) throw Invalid("无效权限类型");
		var name = input["name"] is JsonObject localized ? localized.ToJsonString() : Required(input, "name", 1000);
		var args = new { id, name, code, description = Text(input, "description"), resource = Text(input, "resource"), action = Text(input, "action"), type, parent, path = Text(input, "path"), component = Text(input, "component"), icon = Text(input, "icon"), sort = input["sort"]?.GetValue<int>() ?? 0, status = Status(input), visible = input["visible"]?.GetValue<bool>() ?? true };
		if (old is null) id = (await db.Client.Ado.SqlQueryAsync<long>("INSERT INTO sys_permission(name,code,description,resource,action,type,parent_id,path,component,icon,sort,status,visible) VALUES(@name,@code,@description,@resource,@action,@type,CAST(@parent AS bigint),@path,@component,@icon,@sort,@status,@visible) RETURNING id", args)).Single();
		else await Execute("UPDATE sys_permission SET name=@name,description=@description,resource=@resource,action=@action,type=@type,parent_id=CAST(@parent AS bigint),path=@path,component=@component,icon=@icon,sort=@sort,status=@status,visible=@visible WHERE id=@id", args);
		return id;
	}
	public sealed class UserRoleLink { public long UserId { get; set; } public long RoleId { get; set; } }
}
