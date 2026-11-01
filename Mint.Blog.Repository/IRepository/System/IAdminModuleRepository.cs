using System.Text.Json.Nodes;
namespace Mint.Blog.Repository.IRepository.System;
public interface IAdminModuleRepository {
    Task LockAsync();
    Task<List<JsonObject>> RowsAsync(string resource, long? id = null);
    Task<(List<JsonObject> Rows, long Total)> QueryAsync(string resource, string mode, string? key, IReadOnlyDictionary<string, string> query, int current, int size, DateTimeOffset? startTime, DateTimeOffset? endTime, bool paged);
    Task DeleteAsync(string resource, long? id);
    Task UpdateAsync(string resource, long? id, string data);
    Task<long> InsertAsync(string resource, string data);
    Task AppendLogAsync(string resource, string data);
    Task ClearLogsAsync(string resource);
}
