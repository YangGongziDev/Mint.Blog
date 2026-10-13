using System.Diagnostics;
using System.Text.Json.Nodes;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Auth;

namespace Mint.Blog.WebApi.Middleware;

public sealed class AdminAuditMiddleware(RequestDelegate next, ILogger<AdminAuditMiddleware> logger) {
	public async Task InvokeAsync(HttpContext context, IAdminModuleService service){
		var path = context.Request.Path.Value ?? "";
		if (!path.StartsWith("/api/") || HttpMethods.IsGet(context.Request.Method) || HttpMethods.IsHead(context.Request.Method)) { await next(context); return; }
		var watch = Stopwatch.StartNew();
		Exception? failure = null;
		try { await next(context); }
		catch (Exception exception) { failure = exception; throw; }
		finally {
			var success = failure is null && context.Response.StatusCode < 400;
			var entry = new JsonObject {
				["username"] = context.User.Identity?.Name ?? context.Items["AdminLoginUsername"]?.ToString() ?? "",
				["ip"] = context.Connection.RemoteIpAddress?.ToString() ?? "",
				["browser"] = context.Request.Headers.UserAgent.ToString()[..Math.Min(256, context.Request.Headers.UserAgent.ToString().Length)],
				["os"] = "", ["status"] = success ? "success" : "fail",
				["message"] = success ? "成功" : "请求失败",
				["errorMsg"] = failure is BusinessException business ? business.ErrorCode : success ? "" : "REQUEST_FAILED",
				["module"] = path.Split('/', StringSplitOptions.RemoveEmptyEntries).ElementAtOrDefault(1) ?? "",
				["action"] = context.Request.Method switch { "POST" => "create", "PUT" or "PATCH" => "update", "DELETE" => "delete", _ => "other" },
				["description"] = path, ["method"] = context.Request.Method, ["url"] = path, ["duration"] = watch.ElapsedMilliseconds
			};
			try { await service.RecordLogAsync(path == "/api/auth/login" ? "loginLog" : "operationLog", entry); }
			catch (Exception exception) { logger.LogError("管理审计写入失败，异常类型 {ExceptionType}", exception.GetType().Name); }
		}
	}
}
