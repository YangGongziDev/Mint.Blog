using System.Diagnostics;
using System.Text.Json.Nodes;
using Mint.Blog.Service.IService.System;
using Npgsql;

namespace Mint.Blog.WebApi.Middleware;

public sealed class AdminAuditMiddleware(RequestDelegate next, ILogger<AdminAuditMiddleware> logger) {
	public async Task InvokeAsync(HttpContext context, IAdminAuditService service){
		var path = context.Request.Path.Value ?? "";
		if (!path.StartsWith("/api/") || HttpMethods.IsGet(context.Request.Method) || HttpMethods.IsHead(context.Request.Method)) { await next(context); return; }
		var watch = Stopwatch.StartNew();
		Exception? failure = null;
		try { await next(context); }
		catch (Exception exception) { failure = exception; throw; }
		finally {
			var success = failure is null && context.Response.StatusCode < 400;
			var parts = path.Split('/', StringSplitOptions.RemoveEmptyEntries);
			var module = parts.ElementAtOrDefault(1) switch {
				"system" => parts.ElementAtOrDefault(2) ?? "",
				"admin" when parts.ElementAtOrDefault(2) == "articles" => "admin",
				"admin" or "surfer" => "blog",
				_ => parts.ElementAtOrDefault(1) ?? ""
			};
			var entry = new JsonObject {
				["username"] = context.User.Identity?.Name ?? context.Items["AdminLoginUsername"]?.ToString() ?? "",
				["ip"] = context.Connection.RemoteIpAddress?.ToString() ?? "",
				["browser"] = context.Request.Headers.UserAgent.ToString()[..Math.Min(256, context.Request.Headers.UserAgent.ToString().Length)],
				["os"] = "", ["status"] = success ? "success" : "fail",
				["message"] = success ? "成功" : "请求失败",
				["errorMsg"] = failure is BusinessException business ? business.ErrorCode : success ? "" : "REQUEST_FAILED",
				["module"] = module,
				["action"] = context.Request.Method switch { "POST" => "create", "PUT" or "PATCH" => "update", "DELETE" => "delete", _ => "other" },
				["description"] = path, ["method"] = context.Request.Method, ["url"] = path, ["duration"] = watch.ElapsedMilliseconds
			};
			try { await service.RecordLogAsync(path == "/api/system/auth/login" ? "loginLog" : "operationLog", entry); }
			catch (PostgresException exception) {
				// 仅记录数据库诊断元数据；异常正文和 Detail 等字段可能包含请求数据或 SQL 参数。
				logger.LogError("管理审计写入失败，异常类型 {ExceptionType}，SqlState={SqlState}，Position={Position}，InternalPosition={InternalPosition}，SchemaName={SchemaName}，TableName={TableName}，ColumnName={ColumnName}，DataTypeName={DataTypeName}，ConstraintName={ConstraintName}",
					exception.GetType().Name, exception.SqlState, exception.Position, exception.InternalPosition,
					exception.SchemaName, exception.TableName, exception.ColumnName, exception.DataTypeName, exception.ConstraintName);
			}
			catch (Exception exception) { logger.LogError("管理审计写入失败，异常类型 {ExceptionType}", exception.GetType().Name); }
		}
	}
}
