using System.Text.Json.Nodes;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Repository.Persistence;
namespace Mint.Blog.Repository.Repositorys.System;
public sealed class AdminModuleRepository(ISqlSugarDbContext db) : IAdminModuleRepository {
    private const string RecordSql = "SELECT (data || jsonb_build_object('id',id::text,'createTime',create_time,'updateTime',update_time))::text FROM sys_admin_record";
    public Task LockAsync() => db.Client.Ado.ExecuteCommandAsync("SELECT pg_advisory_xact_lock(2026101202)");
    public async Task<List<JsonObject>> RowsAsync(string resource, long? id = null) => (await db.Client.Ado.SqlQueryAsync<string>(RecordSql + " WHERE resource=@resource" + (id.HasValue ? " AND id=@id" : "") + " ORDER BY id", new { resource, id })).Select(s => JsonNode.Parse(s)!.AsObject()).ToList();
    public async Task<(List<JsonObject> Rows, long Total)> QueryAsync(string resource, string mode, string? key, IReadOnlyDictionary<string, string> query, int current, int size, DateTimeOffset? startTime, DateTimeOffset? endTime, bool paged) {
        var filters = new List<string> { "resource=@resource" };
        var args = new List<SqlSugar.SugarParameter> { new("@resource", resource) };
        if (resource == "dictData" && mode is "all" or "byType") filters.Add("data->>'status'='enabled' AND EXISTS (SELECT 1 FROM sys_admin_record types WHERE types.resource='dictType' AND types.data->>'status'='enabled' AND types.data->>'code'=sys_admin_record.data->>'typeCode')");
        if (mode is "byType" or "key") { filters.Add($"data->>'{(mode == "byType" ? "typeCode" : "key")}'=@key"); args.Add(new("@key", key ?? "")); }
        if (mode != "key") {
            foreach (var field in new[] { "name", "code", "label", "value", "typeCode", "status", "key", "group", "ext", "storage", "username", "module", "action", "ip" })
                if (query.TryGetValue(field, out var value) && !string.IsNullOrEmpty(value)) {
                    var parameter = "@filter" + args.Count;
                    filters.Add(field is "typeCode" or "status" or "group" or "ext" or "storage" or "module" or "action" ? $"coalesce(data->>'{field}','')={parameter}" : $"strpos(lower(coalesce(data->>'{field}','')),lower({parameter}))>0");
                    args.Add(new(parameter, value));
                }
            if (startTime.HasValue) { filters.Add("create_time>=@startTime"); args.Add(new("@startTime", startTime.Value.UtcDateTime)); }
            if (endTime.HasValue) { filters.Add("create_time<=@endTime"); args.Add(new("@endTime", endTime.Value.UtcDateTime)); }
        }
        var where = " WHERE " + string.Join(" AND ", filters);
        var total = paged ? (await db.Client.Ado.SqlQueryAsync<long>("SELECT count(*) FROM sys_admin_record" + where, args.ToArray())).Single() : 0;
        var suffix = " ORDER BY coalesce((data->>'sort')::integer,0),id DESC";
        if (paged) { suffix += " LIMIT @limit OFFSET @offset"; args.Add(new("@limit", size)); args.Add(new("@offset", (current - 1) * size)); }
        var rows = (await db.Client.Ado.SqlQueryAsync<string>(RecordSql + where + suffix, args.ToArray())).Select(s => JsonNode.Parse(s)!.AsObject()).ToList();
        return (rows, total);
    }
    public Task DeleteAsync(string resource, long? id) => db.Client.Ado.ExecuteCommandAsync("DELETE FROM sys_admin_record WHERE resource=@resource AND id=@id", new { resource, id });
    public Task UpdateAsync(string resource, long? id, string data) => db.Client.Ado.ExecuteCommandAsync("UPDATE sys_admin_record SET data=CAST(@data AS jsonb),update_time=now() WHERE id=@id AND resource=@resource", new { id, resource, data });
    public async Task<long> InsertAsync(string resource, string data) => (await db.Client.Ado.SqlQueryAsync<long>("INSERT INTO sys_admin_record(resource,data) VALUES(@resource,CAST(@data AS jsonb)) RETURNING id", new { resource, data })).Single();
    public Task AppendLogAsync(string resource, string data) => db.Client.Ado.ExecuteCommandAsync("INSERT INTO sys_admin_record(resource,data) VALUES(@resource,CAST(@data AS jsonb))", new { resource, data });
    public Task ClearLogsAsync(string resource) => db.Client.Ado.ExecuteCommandAsync("DELETE FROM sys_admin_record WHERE resource=@resource", new { resource });
}
