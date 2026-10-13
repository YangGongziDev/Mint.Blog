using System.Text.Json.Nodes;
using Mint.Blog.Application.System.Auth;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;

namespace Mint.Blog.Infrastructure.System.Auth;

public sealed class AdminIdentityQuery(ISqlSugarDbContext db) : IAdminIdentityQuery {
	public async Task<AdminUser?> GetAsync(string username, CancellationToken cancellationToken = default){
		var users = await db.Client.Ado.SqlQueryAsync<IdentityRow>("SELECT id, username, display_name AS realname, email, phone, avatar, status, create_time AS createdat, update_time AS updatedat FROM sys_user WHERE username=@username AND is_deleted=0 AND status='active'", new { username });
		var user = users.SingleOrDefault();
		if (user is null) return null;
		var roles = await db.Client.Ado.SqlQueryAsync<RoleRow>("SELECT r.id,r.name,r.code,r.description,r.create_time AS createdat,r.update_time AS updatedat FROM sys_role r JOIN sys_user_role ur ON ur.role_id=r.id WHERE ur.user_id=@id", new { id = user.Id });
		var permissions = await db.Client.Ado.SqlQueryAsync<PermissionRow>("SELECT DISTINCT p.* FROM sys_permission p JOIN sys_role_permission rp ON rp.permission_id=p.id JOIN sys_user_role ur ON ur.role_id=rp.role_id WHERE ur.user_id=@id AND p.status='active'", new { id = user.Id });
		var links = await db.Client.Ado.SqlQueryAsync<RolePermissionRow>("SELECT rp.role_id AS roleid,rp.permission_id AS permissionid FROM sys_role_permission rp JOIN sys_user_role ur ON ur.role_id=rp.role_id WHERE ur.user_id=@id", new { id = user.Id });
		var mapped = permissions.Select(p => new AdminPermission(p.Id.ToString(), p.Name.StartsWith('{') ? JsonNode.Parse(p.Name)! : JsonValue.Create(p.Name)!, p.Code, p.Description, p.Resource, p.Action, p.Type, p.Parent_Id?.ToString(), p.Path, p.Component, p.Icon, p.Sort, p.Status, p.Visible)).ToList();
		var mappedRoles = roles.Select(r => new AdminRole(r.Id.ToString(), r.Name, r.Code, r.Description, mapped.Where(p => links.Any(l => l.RoleId == r.Id && l.PermissionId.ToString() == p.Id)).ToList(), r.CreatedAt, r.UpdatedAt)).ToList();
		return new AdminUser(user.Id.ToString(), user.Username, user.RealName, user.Email, user.Phone, user.Avatar, user.Status, user.CreatedAt, user.UpdatedAt, mappedRoles, mapped);
	}
	public sealed class IdentityRow {
		public long Id { get; set; }
		public string Username { get; set; } = "";
		public string RealName { get; set; } = "";
		public string Email { get; set; } = "";
		public string Phone { get; set; } = "";
		public string Avatar { get; set; } = "";
		public string Status { get; set; } = "active";
		public DateTimeOffset CreatedAt { get; set; }
		public DateTimeOffset UpdatedAt { get; set; }
	}
	public sealed class RoleRow {
		public long Id { get; set; }
		public string Name { get; set; } = "";
		public string Code { get; set; } = "";
		public string Description { get; set; } = "";
		public DateTimeOffset CreatedAt { get; set; }
		public DateTimeOffset UpdatedAt { get; set; }
	}
	public sealed class PermissionRow {
		public long Id { get; set; }
		public string Name { get; set; } = "";
		public string Code { get; set; } = "";
		public string Description { get; set; } = "";
		public string Resource { get; set; } = "";
		public string Action { get; set; } = "";
		public string Type { get; set; } = "menu";
		public long? Parent_Id { get; set; }
		public string? Path { get; set; }
		public string? Component { get; set; }
		public string? Icon { get; set; }
		public int Sort { get; set; }
		public string Status { get; set; } = "active";
		public bool Visible { get; set; }
	}
	public sealed class RolePermissionRow {
		public long RoleId { get; set; }
		public long PermissionId { get; set; }
	}
}
