using System.Text.Json.Nodes;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Auth;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;

namespace Mint.Blog.Infrastructure.System.Auth;

public sealed class AdminModuleService(ISqlSugarDbContext db, IObjectStorageService storage) : IAdminModuleService {
	private static BusinessException Invalid(string message) => new("VALIDATION_ERROR", message);
	private static string Text(JsonObject row, string key) => row[key]?.ToString() ?? "";
	private const string RecordSql = "SELECT (data || jsonb_build_object('id',id::text,'createTime',create_time,'updateTime',update_time))::text FROM sys_admin_record";
	private async Task<List<JsonObject>> Rows(string resource, long? id = null) => (await db.Client.Ado.SqlQueryAsync<string>(RecordSql + " WHERE resource=@resource" + (id.HasValue ? " AND id=@id" : "") + " ORDER BY id", new { resource, id })).Select(s => JsonNode.Parse(s)!.AsObject()).ToList();
	public async Task<object?> ReadAsync(string resource, string mode, string? key, IReadOnlyDictionary<string, string> query){
		var current = PageNumber(query, "current", PageNumber(query, "page", 1, 1000000), 1000000);
		var size = PageNumber(query, "pageSize", 10, 1000);
		var startTime = QueryTime(query, "startTime");
		var endTime = QueryTime(query, "endTime");
		if (startTime > endTime) throw Invalid("开始时间不能晚于结束时间");
		if (query.TryGetValue("status", out var status) && status != "" &&
			!(resource is "loginLog" or "operationLog" ? status is "success" or "fail" : status is "enabled" or "disabled")) throw Invalid("无效状态");
		var filters = new List<string> { "resource=@resource" };
		var args = new List<SqlSugar.SugarParameter> { new("@resource", resource) };
		if (resource == "dictData" && mode is "all" or "byType")
			filters.Add("data->>'status'='enabled' AND EXISTS (SELECT 1 FROM sys_admin_record types WHERE types.resource='dictType' AND types.data->>'status'='enabled' AND types.data->>'code'=sys_admin_record.data->>'typeCode')");
		if (mode is "byType" or "key") { filters.Add($"data->>'{(mode == "byType" ? "typeCode" : "key")}'=@key"); args.Add(new("@key", key ?? "")); }
		if (mode != "key") {
			foreach (var field in new[] { "name", "code", "label", "value", "typeCode", "status", "key", "group", "ext", "storage", "username", "module", "action", "ip" })
				if (query.TryGetValue(field, out var value) && !string.IsNullOrEmpty(value)) {
					var parameter = "@filter" + args.Count;
					filters.Add(field is "typeCode" or "status" or "group" or "ext" or "storage" or "module" or "action"
						? $"coalesce(data->>'{field}','')={parameter}" : $"strpos(lower(coalesce(data->>'{field}','')),lower({parameter}))>0");
					args.Add(new(parameter, value));
				}
			if (startTime.HasValue) { filters.Add("create_time>=@startTime"); args.Add(new("@startTime", startTime.Value.UtcDateTime)); }
			if (endTime.HasValue) { filters.Add("create_time<=@endTime"); args.Add(new("@endTime", endTime.Value.UtcDateTime)); }
		}
		var where = " WHERE " + string.Join(" AND ", filters);
		var paged = mode is not ("all" or "byType" or "tree" or "key") && resource != "dept";
		var total = paged ? (await db.Client.Ado.SqlQueryAsync<long>("SELECT count(*) FROM sys_admin_record" + where, args.ToArray())).Single() : 0;
		var suffix = " ORDER BY coalesce((data->>'sort')::integer,0),id DESC";
		if (paged) { suffix += " LIMIT @limit OFFSET @offset"; args.Add(new("@limit", size)); args.Add(new("@offset", (current - 1) * size)); }
		var rows = (await db.Client.Ado.SqlQueryAsync<string>(RecordSql + where + suffix, args.ToArray())).Select(s => JsonNode.Parse(s)!.AsObject()).ToList();
		if (mode == "key") return rows.SingleOrDefault() ?? throw Invalid("配置不存在");
		if (mode == "tree") {
			var all = await Rows(resource);
			var ids = rows.Select(r => Text(r, "id")).ToHashSet();
			foreach (var row in rows.ToArray()) {
				var parent = Text(row, "parentId");
				while (parent != "" && ids.Add(parent)) {
					var node = all.Single(r => Text(r, "id") == parent);
					rows.Add(node); parent = Text(node, "parentId");
				}
			}
			return AdminRbacService.Tree(rows);
		}
		if (mode is "all" or "byType" || resource == "dept") return rows;
		return new { list = rows, total, current, pageSize = size };
	}
	public async Task<object?> SaveAsync(string resource, long? id, JsonObject input, bool delete = false){
		if (resource is not ("dept" or "dictType" or "dictData" or "config" or "file")) throw Invalid("无效资源");
		if (id <= 0 || (delete && !id.HasValue)) throw Invalid("无效记录 ID");
		var fields = resource switch {
			"dept" => new[] { "name", "parentId", "leader", "phone", "email", "sort", "status", "remark" },
			"dictType" => ["name", "code", "description", "status"],
			"dictData" => ["typeCode", "label", "value", "sort", "status", "remark"],
			_ => ["name", "key", "value", "valueType", "group", "description", "sort"]
		};
		if (!delete) foreach (var field in fields) {
			if (!input.TryGetPropertyValue(field, out var node)) continue;
			if (field == "parentId" && node is null) continue;
			if (field == "sort") {
				if (node is not JsonValue number || !number.TryGetValue<int>(out _)) throw Invalid("sort 必须是 32 位整数");
			} else if (node is not JsonValue text || !text.TryGetValue<string>(out _)) throw Invalid($"{field} 必须是字符串");
		}
		await db.Client.Ado.BeginTranAsync();
		try {
			await db.Client.Ado.ExecuteCommandAsync("SELECT pg_advisory_xact_lock(2026101202)");
			var rows = await Rows(resource);
			var old = id.HasValue ? rows.SingleOrDefault(r => Text(r, "id") == id.ToString()) ?? throw Invalid("记录不存在") : null;
			if (resource == "file" && !delete) throw Invalid("请使用上传接口");
			if (delete){
				if (resource == "dept" && rows.Any(r => Text(r, "parentId") == id.ToString())) throw Invalid("请先删除子部门");
				if (resource == "dictType" && (await Rows("dictData")).Any(r => Text(r, "typeCode") == Text(old!, "code"))) throw Invalid("请先删除字典数据");
				if (resource == "config" && old!["builtIn"]?.GetValue<bool>() == true) throw Invalid("内置配置不能删除");
				if (resource == "file") await storage.DeleteAsync(Text(old!, "path"));
				await db.Client.Ado.ExecuteCommandAsync("DELETE FROM sys_admin_record WHERE resource=@resource AND id=@id", new { resource, id });
			} else {
				var row = old is null ? new JsonObject() : (JsonObject)old.DeepClone();
				foreach (var field in fields) if (input.ContainsKey(field)) row[field] = input[field]?.DeepClone();
				if (resource is "dept" or "dictData" or "config") row["sort"] ??= 0;
				if (resource == "config") row["value"] ??= "";
				foreach (var field in resource == "dictData" ? new[] { "typeCode", "label", "value" } : resource == "config" ? ["name", "key", "valueType"] : resource == "dictType" ? ["name", "code"] : ["name"])
					if (string.IsNullOrWhiteSpace(Text(row, field))) throw Invalid($"{field} 必填");
				if (resource != "config") {
					row["status"] ??= "enabled";
					if (Text(row, "status") is not ("enabled" or "disabled")) throw Invalid("无效状态");
				}
				if (resource == "dept") {
					if (Text(row, "parentId") == "") row["parentId"] = null;
					var seen = new HashSet<string>(); var parent = Text(row, "parentId");
					while (parent != "") {
						if (parent == id?.ToString() || !seen.Add(parent)) throw Invalid("不能形成循环父子关系");
						var node = rows.SingleOrDefault(r => Text(r, "id") == parent) ?? throw Invalid("父部门不存在");
						parent = Text(node, "parentId");
					}
				}
				if (resource is "dictType" or "config") {
					var field = resource == "dictType" ? "code" : "key";
					if (old is not null && Text(row, field) != Text(old, field)) throw Invalid("编码不可修改");
					if (rows.Any(r => Text(r, field) == Text(row, field) && Text(r, "id") != id?.ToString())) throw Invalid("编码重复");
				}
				if (resource == "dictData") {
					if (!(await Rows("dictType")).Any(r => Text(r, "code") == Text(row, "typeCode"))) throw Invalid("字典类型不存在");
					if (rows.Any(r => Text(r, "typeCode") == Text(row, "typeCode") && Text(r, "value") == Text(row, "value") && Text(r, "id") != id?.ToString())) throw Invalid("同类型字典值重复");
				}
				if (resource == "config") {
					row["builtIn"] = old?["builtIn"]?.GetValue<bool>() ?? false;
					var value = Text(row, "value");
					var valid = Text(row, "valueType") switch { "string" => true, "number" => double.TryParse(value, global::System.Globalization.NumberStyles.Float, global::System.Globalization.CultureInfo.InvariantCulture, out var number) && double.IsFinite(number), "boolean" => value is "true" or "false", "json" => IsJson(value), _ => false };
					if (!valid) throw Invalid("配置值与类型不一致");
				}
				row.Remove("id"); row.Remove("createTime"); row.Remove("updateTime");
				var data = row.ToJsonString();
				if (id.HasValue) await db.Client.Ado.ExecuteCommandAsync("UPDATE sys_admin_record SET data=CAST(@data AS jsonb),update_time=now() WHERE id=@id AND resource=@resource", new { id, resource, data });
				else id = (await db.Client.Ado.SqlQueryAsync<long>("INSERT INTO sys_admin_record(resource,data) VALUES(@resource,CAST(@data AS jsonb)) RETURNING id", new { resource, data })).Single();
			}
			await db.Client.Ado.CommitTranAsync();
			return delete ? null : (await Rows(resource, id)).Single();
		} catch { await db.Client.Ado.RollbackTranAsync(); throw; }
	}
	private static int PageNumber(IReadOnlyDictionary<string, string> query, string key, int fallback, int maximum){
		if (!query.TryGetValue(key, out var value)) return fallback;
		if (!int.TryParse(value, out var number) || number < 1 || number > maximum) throw Invalid($"{key} 必须在 1 至 {maximum} 之间");
		return number;
	}
	private static DateTimeOffset? QueryTime(IReadOnlyDictionary<string, string> query, string key){
		if (!query.TryGetValue(key, out var value) || value == "") return null;
		if (!DateTimeOffset.TryParse(value, out var time)) throw Invalid($"{key} 时间格式无效");
		return time;
	}
	private static bool IsJson(string value){ try { JsonNode.Parse(value); return true; } catch (global::System.Text.Json.JsonException) { return false; } }
	public async Task<object> UploadAsync(Stream stream, long length, string name, string contentType, string username, CancellationToken cancellationToken){
		if (length <= 0 || length > 20 * 1024 * 1024) throw Invalid("文件大小须在 1 字节至 20 MB 之间");
		name = Path.GetFileName(name);
		var ext = Path.GetExtension(name).ToLowerInvariant();
		if (!new[] { ".png", ".jpg", ".jpeg", ".webp", ".gif", ".pdf", ".txt", ".csv", ".zip", ".docx", ".xlsx" }.Contains(ext)) throw Invalid("不支持此文件类型");
		var safeType = ext switch { ".png" => "image/png", ".jpg" or ".jpeg" => "image/jpeg", ".webp" => "image/webp", ".gif" => "image/gif", ".pdf" => "application/pdf", _ => "application/octet-stream" };
		var path = await storage.UploadAsync(stream, length, $"{Guid.NewGuid():N}{ext}", safeType, cancellationToken);
		try {
			var row = new JsonObject { ["name"] = name, ["originalName"] = name, ["path"] = path, ["size"] = length, ["mimeType"] = safeType, ["ext"] = ext.TrimStart('.'), ["storage"] = "oss", ["uploader"] = username, ["remark"] = "" };
			var id = (await db.Client.Ado.SqlQueryAsync<long>("INSERT INTO sys_admin_record(resource,data) VALUES('file',CAST(@data AS jsonb)) RETURNING id", new { data = row.ToJsonString() })).Single();
			return (await Rows("file", id)).Single();
		} catch { await storage.DeleteAsync(path, cancellationToken); throw; }
	}
	public Task RecordLogAsync(string resource, JsonObject entry){
		if (resource is not ("loginLog" or "operationLog")) throw Invalid("无效日志类型");
		return db.Client.Ado.ExecuteCommandAsync("INSERT INTO sys_admin_record(resource,data) VALUES(@resource,CAST(@data AS jsonb))", new { resource, data = entry.ToJsonString() });
	}
	public Task ClearLogsAsync(string resource){
		if (resource is not ("loginLog" or "operationLog")) throw Invalid("无效日志类型");
		return db.Client.Ado.ExecuteCommandAsync("DELETE FROM sys_admin_record WHERE resource=@resource", new { resource });
	}
}
