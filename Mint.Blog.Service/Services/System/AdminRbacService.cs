using System.Text.Json.Nodes;
using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Common.Security;
using Mint.Blog.Model.Vos.System;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Service.IService.System;

namespace Mint.Blog.Service.Services.System;

public sealed class AdminRbacService(IAdminRbacRepository repository, IAdminIdentityQuery identities, IPasswordHasher passwords, IUnitOfWork unitOfWork) : IAdminRbacService {
    private static BusinessException Invalid(string message) => new("VALIDATION_ERROR", message);
    private static BusinessException Forbidden(string message) => new(ErrorCodes.Forbidden, message);
    private static string Text(JsonObject input, string key, string fallback = "") => input[key] is null ? fallback : input[key] is JsonValue value && value.TryGetValue<string>(out var text) ? text : throw Invalid($"{key} 必须是字符串");
    private static long Id(string value) => long.TryParse(value, global::System.Globalization.NumberStyles.None, global::System.Globalization.CultureInfo.InvariantCulture, out var id) && id > 0 ? id : throw Invalid("无效的 ID");
    private static HashSet<long> Ids(JsonObject input, string key) {
        if (input[key] is not JsonArray values) throw Invalid($"{key} 必须是 ID 数组");
        return values.Select(x => x is JsonValue ? Id(x.ToString()) : throw Invalid("无效的 ID")).ToHashSet();
    }
    private static string Required(JsonObject input, string key, int max = 150) {
        var value = Text(input, key).Trim();
        if (value.Length == 0 || value.Length > max) throw Invalid($"{key} 必填且不得超过 {max} 字符");
        return value;
    }
    private static string Status(JsonObject input) {
        var value = Text(input, "status", "active");
        return value is "active" or "inactive" ? value : throw Invalid("无效状态");
    }
    public static JsonArray Tree(List<JsonObject> rows, string? parent = null, HashSet<string>? ancestors = null) {
        ancestors ??= [];
        var result = new JsonArray();
        foreach (var row in rows.Where(r => r["parentId"]?.ToString() == parent)) {
            var id = Text(row, "id");
            if (!ancestors.Add(id)) throw Invalid("树中存在循环关联");
            var node = (JsonObject)row.DeepClone();
            node["children"] = Tree(rows, id, ancestors);
            ancestors.Remove(id);
            result.Add(node);
        }
        return result;
    }
    public async Task<object> AssignableAsync(string resource, string username) {
        var actor = await identities.GetAsync(username) ?? throw Forbidden("账号已禁用");
        var super = actor.Permissions.Any(p => p.Code == "*");
        var entity = resource switch { "users" => "user", "roles" => "role", _ => throw Invalid("无效资源") };
        if (!super && !actor.Permissions.Any(p => p.Code == $"system.{entity}.add" || p.Code == $"system.{entity}.edit")) throw Forbidden("无操作权限");
        if (resource == "users") return (await repository.RolesAsync()).Where(r => super ||
            (Text(r, "code") is not ("ROLE_ADMIN" or "ROLE_SUPER") && r["permissions"]!.AsArray().OfType<JsonObject>().All(p => InScope(p, actor)))).ToList();
        var permissions = await repository.PermissionsAsync();
        var allowed = permissions.Where(p => Text(p, "status") == "active" && (super || InScope(p, actor))).Select(p => Text(p, "id")).ToHashSet();
        var rows = permissions.Where(p => allowed.Contains(Text(p, "id"))).ToList();
        foreach (var row in rows) if (row["parentId"] is not null && !allowed.Contains(Text(row, "parentId"))) row["parentId"] = null;
        return Tree(rows);
    }
    private static bool InScope(JsonObject permission, AdminUser actor) => Text(permission, "status") == "active" && Text(permission, "code") != "*" && actor.Permissions.Any(a => a.Id == Text(permission, "id") && a.Code == Text(permission, "code"));
    public async Task<object> ReadAsync(string resource, long? id, IReadOnlyDictionary<string, string> query) {
        if (resource is "users" or "roles") {
            var page = (query.TryGetValue("current", out var p) || query.TryGetValue("page", out p)) && int.TryParse(p, out var pn) ? Math.Clamp(pn, 1, 1000000) : 1;
            var size = query.TryGetValue("pageSize", out var s) && int.TryParse(s, out var sn) ? Math.Clamp(sn, 1, 1000) : 10;
            var (records, total) = await repository.ReadPageAsync(resource, id, query, page, size);
            if (id.HasValue) return records.SingleOrDefault() ?? throw Invalid("记录不存在");
            return new { list = records, total, current = page, pageSize = size };
        }
        var rows = resource == "permissions" ? await repository.PermissionsAsync() : throw Invalid("无效资源");
        if (id.HasValue) return rows.SingleOrDefault(r => Text(r, "id") == id.ToString()) ?? throw Invalid("记录不存在");
        var allRows = rows;
        foreach (var key in new[] { "username", "realName", "email", "phone", "status", "name", "code", "type", "resource" })
            if (query.TryGetValue(key, out var value) && !string.IsNullOrWhiteSpace(value)) rows = rows.Where(r => key is "status" or "type"
                ? string.Equals(r[key]?.ToString(), value, StringComparison.Ordinal)
                : (r[key]?.ToString() ?? "").Contains(value, StringComparison.OrdinalIgnoreCase)).ToList();
        if (query.TryGetValue("keyword", out var keyword) && !string.IsNullOrWhiteSpace(keyword)) rows = rows.Where(r => new[] { "name", "code", "description", "resource", "path" }.Any(key => (r[key]?.ToString() ?? "").Contains(keyword.Trim(), StringComparison.OrdinalIgnoreCase))).ToList();
        var byId = allRows.ToDictionary(r => Text(r, "id"));
        var included = rows.Select(r => Text(r, "id")).ToHashSet();
        foreach (var row in rows) {
            var parent = row["parentId"]?.ToString();
            while (parent is not null && byId.TryGetValue(parent, out var ancestor) && included.Add(parent)) parent = ancestor["parentId"]?.ToString();
        }
        return Tree(allRows.Where(r => included.Contains(Text(r, "id"))).ToList());
    }
    public async Task<object?> WriteAsync(string resource, long? id, JsonObject? input, string username, bool delete = false) {
        input ??= new JsonObject();
        if (!delete) {
            if (resource == "users" && input.ContainsKey("roleIds")) _ = Ids(input, "roleIds");
            if (resource == "roles" && input.ContainsKey("permissionIds")) _ = Ids(input, "permissionIds");
        }
        await unitOfWork.BeginTransactionAsync();
        try {
            await repository.LockAsync();
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
            await unitOfWork.CommitAsync();
        } catch { await unitOfWork.RollbackAsync(); throw; }
        return delete ? null : await ReadAsync(resource, id, new Dictionary<string, string>());
    }
    private static void CheckScope(IEnumerable<JsonObject> permissions, AdminUser actor, bool super) {
        if (!super && permissions.Any(p => !InScope(p, actor))) throw Forbidden("不能管理或分配超出自身权限的角色");
    }
    private async Task<long?> SaveUser(long? id, JsonObject input, AdminUser actor, bool super, bool delete) {
        var old = id.HasValue ? (await repository.UsersAsync(id)).SingleOrDefault() ?? throw Invalid("用户不存在") : null;
        var oldPermissions = old?["roles"]!.AsArray().OfType<JsonObject>().SelectMany(r => r["permissions"]!.AsArray()).OfType<JsonObject>().ToList() ?? [];
        if (old is not null && id?.ToString() != actor.Id) CheckScope(oldPermissions.Where(p => Text(p, "status") == "active"), actor, super);
        HashSet<long>? selected = input.ContainsKey("roleIds") ? Ids(input, "roleIds") : null;
        if (input.ContainsKey("roles") && selected is null) throw Invalid("请使用 roleIds 分配角色");
        var oldRoleIds = old?["roles"]!.AsArray().OfType<JsonObject>().Select(r => Id(Text(r, "id"))).ToHashSet() ?? [];
        var rolesChanged = selected is not null && !selected.SetEquals(oldRoleIds);
        if (id?.ToString() == actor.Id && (delete || rolesChanged || Text(input, "status", "active") != "active")) throw Forbidden("不能删除、禁用自己或修改自己的角色");
        if (delete) { await repository.DeleteUserAsync(id); await repository.RevokeAsync(id!.Value); return id; }
        if (rolesChanged) {
            var assigned = await repository.RolesAsync(ids: selected!);
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
        if (await repository.UserNameExistsAsync(name, id ?? 0L)) throw Invalid("用户名已存在");
        var args = new { id, username = name, realName = Required(merged, "realName", 100), email = Text(merged, "email"), phone = Text(merged, "phone"), avatar = Text(merged, "avatar"), gender = Text(merged, "gender"), birthDate = Text(merged, "birthDate"), bio = Text(merged, "bio"), status = Status(merged) };
        if (old is null) {
            var password = Text(input, "password");
            if (password.Length < 8 || global::System.Text.Encoding.UTF8.GetByteCount(password) > 72) throw Invalid("密码至少 8 字符且不超过 72 字节");
            id = await repository.InsertUserAsync(new { args.username, args.realName, password = passwords.Hash(password), args.email, args.phone, args.avatar, args.gender, args.birthDate, args.bio, args.status });
        } else {
            if (input.ContainsKey("password")) throw Invalid("请使用改密接口修改密码");
            await repository.UpdateUserAsync(args);
        }
        if (rolesChanged) await repository.ReplaceUserRolesAsync(id, selected!);
        if (old is not null && (rolesChanged || args.status != "active")) await repository.RevokeAsync(id!.Value);
        return id;
    }
    private async Task<long?> SaveRole(long? id, JsonObject input, AdminUser actor, bool super, bool delete) {
        var old = id.HasValue ? (await repository.RolesAsync(id)).SingleOrDefault() ?? throw Invalid("角色不存在") : null;
        var oldPermissions = old?["permissions"]!.AsArray().OfType<JsonObject>().ToList() ?? [];
        if (old is not null) {
            if (Text(old, "code") is "ROLE_SUPER" or "ROLE_ADMIN") throw Forbidden("系统内置角色不可修改或删除");
            if (actor.Roles.Any(r => r.Id == id.ToString())) throw Forbidden("不能修改或删除自己持有的角色");
            CheckScope(oldPermissions.Where(p => Text(p, "status") == "active"), actor, super);
        }
        if (delete) {
            if (await repository.RoleAssignedAsync(id)) throw Invalid("角色已分配给用户，请先解除关联");
            await repository.DeleteRoleAsync(id); return id;
        }
        var code = Required(input, "code", 60);
        if (code is "ROLE_SUPER" or "ROLE_ADMIN" || (old is not null && code != Text(old, "code"))) throw Invalid("角色编码不可修改或使用内置编码");
        if (await repository.RoleCodeExistsAsync(code, id ?? 0L)) throw Invalid("角色编码重复");
        var permissions = await repository.PermissionsAsync();
        var selected = input.ContainsKey("permissionIds") ? Ids(input, "permissionIds") : old is null ? [] : old["permissions"]!.AsArray().OfType<JsonObject>().Select(p => Id(Text(p, "id"))).ToHashSet();
        if (selected.Any(i => !permissions.Any(p => Text(p, "id") == i.ToString()))) throw Invalid("包含不存在的权限");
        var previousIds = oldPermissions.Select(p => Id(Text(p, "id"))).ToHashSet();
        var cleaning = !super && oldPermissions.Any(p => Text(p, "status") != "active");
        if (cleaning && !selected.IsSubsetOf(previousIds)) throw Forbidden("清理失效关联时不能授予新的权限");
        CheckScope(permissions.Where(p => selected.Contains(Id(Text(p, "id"))) && !(Text(p, "status") != "active" && previousIds.Contains(Id(Text(p, "id"))))), actor, super);
        if (input.ContainsKey("permissionIds") && !cleaning) {
            bool changed;
            do { changed = false; foreach (var p in permissions) if (Text(p, "status") == "active" && (super || InScope(p, actor)) && p["parentId"] is not null && selected.Contains(Id(Text(p, "parentId")))) changed |= selected.Add(Id(Text(p, "id"))); } while (changed);
        }
        var name = Required(input, "name", 100);
        var description = Text(input, "description");
        if (old is null) id = await repository.InsertRoleAsync(name, code, description);
        else await repository.UpdateRoleAsync(id, name, description);
        if (input.ContainsKey("permissionIds")) await repository.ReplaceRolePermissionsAsync(id, selected);
        return id;
    }
    private async Task<long?> SavePermission(long? id, JsonObject input, bool delete) {
        var rows = await repository.PermissionsAsync();
        var old = id.HasValue ? rows.SingleOrDefault(r => Text(r, "id") == id.ToString()) ?? throw Invalid("权限不存在") : null;
        if (old is not null && Text(old, "code") == "*") throw Forbidden("所有权限定义不可修改或删除");
        if (delete) {
            if (rows.Any(r => r["parentId"]?.ToString() == id.ToString())) throw Invalid("请先删除子权限");
            await repository.DeletePermissionAsync(id); return id;
        }
        var code = Required(input, "code");
        if (code == "*" || rows.Any(r => Text(r, "code") == code && Text(r, "id") != id?.ToString())) throw Invalid("权限编码重复或保留");
        if (old is not null && code != Text(old, "code")) throw Invalid("权限编码不可修改");
        var parent = string.IsNullOrEmpty(Text(input, "parentId")) ? (long?)null : Id(Text(input, "parentId"));
        var seen = new HashSet<long>();
        var cursor = parent;
        while (cursor.HasValue) {
            if (cursor == id || !seen.Add(cursor.Value)) throw Invalid("不能形成循环父子关系");
            var row = rows.SingleOrDefault(r => Text(r, "id") == cursor.ToString()) ?? throw Invalid("父权限不存在");
            cursor = row["parentId"] is null ? null : Id(Text(row, "parentId"));
        }
        var type = Text(input, "type", "menu");
        if (type is not ("menu" or "button" or "api")) throw Invalid("无效权限类型");
        var name = input["name"] is JsonObject localized ? localized.ToJsonString() : Required(input, "name", 1000);
        var args = new { id, name, code, description = Text(input, "description"), resource = Text(input, "resource"), action = Text(input, "action"), type, parent, path = Text(input, "path"), component = Text(input, "component"), icon = Text(input, "icon"), sort = input["sort"]?.GetValue<int>() ?? 0, status = Status(input), visible = input["visible"]?.GetValue<bool>() ?? true };
        if (old is null) id = await repository.InsertPermissionAsync(args);
        else await repository.UpdatePermissionAsync(args);
        return id;
    }
}
