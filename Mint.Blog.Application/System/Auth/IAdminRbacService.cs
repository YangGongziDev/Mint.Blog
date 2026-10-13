using System.Text.Json.Nodes;

namespace Mint.Blog.Application.System.Auth;

public interface IAdminRbacService {
	Task<object> AssignableAsync(string resource, string username);
	Task<object> ReadAsync(string resource, long? id, IReadOnlyDictionary<string, string> query);
	Task<object?> WriteAsync(string resource, long? id, JsonObject? input, string username, bool delete = false);
}
