using System.Text.Json.Nodes;

namespace Mint.Blog.Repository.IRepository.System;

public interface IAdminRbacRepository {
    Task LockAsync();
    Task<List<JsonObject>> PermissionsAsync();
    Task<List<JsonObject>> RolesAsync(long? id = null, IReadOnlyCollection<long>? ids = null);
    Task<List<JsonObject>> UsersAsync(long? id = null);
    Task<(List<JsonObject> Rows, long Total)> ReadPageAsync(string resource, long? id, IReadOnlyDictionary<string, string> query, int page, int size);
    Task<bool> UserNameExistsAsync(string name, long id);
    Task<bool> RoleCodeExistsAsync(string code, long id);
    Task<bool> RoleAssignedAsync(long? id);
    Task DeleteUserAsync(long? id);
    Task RevokeAsync(long id);
    Task<long> InsertUserAsync(object values);
    Task UpdateUserAsync(object values);
    Task ReplaceUserRolesAsync(long? id, IEnumerable<long> ids);
    Task DeleteRoleAsync(long? id);
    Task<long> InsertRoleAsync(string name, string code, string description);
    Task UpdateRoleAsync(long? id, string name, string description);
    Task ReplaceRolePermissionsAsync(long? id, IEnumerable<long> ids);
    Task DeletePermissionAsync(long? id);
    Task<long> InsertPermissionAsync(object values);
    Task UpdatePermissionAsync(object values);
}
