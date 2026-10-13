using System.Text.Json.Nodes;

namespace Mint.Blog.Application.System.Auth;

public interface IAdminModuleService {
	Task<object?> ReadAsync(string resource, string mode, string? key, IReadOnlyDictionary<string, string> query);
	Task<object?> SaveAsync(string resource, long? id, JsonObject input, bool delete = false);
	Task<object> UploadAsync(Stream stream, long length, string name, string contentType, string username, CancellationToken cancellationToken);
	Task RecordLogAsync(string resource, JsonObject entry);
	Task ClearLogsAsync(string resource);
}
