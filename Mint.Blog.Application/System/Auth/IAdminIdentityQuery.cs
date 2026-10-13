using System.Text.Json.Nodes;

namespace Mint.Blog.Application.System.Auth;

public sealed record AdminPermission(string Id, JsonNode Name, string Code, string Description, string Resource, string Action, string Type, string? ParentId, string? Path, string? Component, string? Icon, int Sort, string Status, bool Visible);
public sealed record AdminRole(string Id, string Name, string Code, string Description, IReadOnlyList<AdminPermission> Permissions, DateTimeOffset CreatedAt, DateTimeOffset UpdatedAt);
public sealed record AdminUser(string Id, string Username, string RealName, string Email, string Phone, string Avatar, string Status, DateTimeOffset CreatedAt, DateTimeOffset UpdatedAt, IReadOnlyList<AdminRole> Roles, IReadOnlyList<AdminPermission> Permissions);

public interface IAdminIdentityQuery {
	Task<AdminUser?> GetAsync(string username, CancellationToken cancellationToken = default);
}
