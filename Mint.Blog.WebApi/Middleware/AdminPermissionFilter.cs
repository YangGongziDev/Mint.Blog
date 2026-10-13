using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Auth;

namespace Mint.Blog.WebApi.Middleware;

public sealed class AdminPermissionFilter(IAdminIdentityQuery identities) : IAsyncAuthorizationFilter {
	public async Task OnAuthorizationAsync(AuthorizationFilterContext context){
		var endpoint = context.HttpContext.GetEndpoint();
		if (endpoint?.Metadata.GetMetadata<IAllowAnonymous>() is not null || endpoint?.Metadata.GetMetadata<IAuthorizeData>() is null) return;
		var username = context.HttpContext.User.Identity?.Name;
		if (string.IsNullOrEmpty(username)) return;
		var user = await identities.GetAsync(username, context.HttpContext.RequestAborted);
		if (user is null) {
			context.Result = new UnauthorizedObjectResult(ApiResponse<object>.Fail(ErrorCodes.Unauthorized, "账号不存在或已禁用"));
			return;
		}
		var path = (context.HttpContext.Request.Path.Value ?? "").TrimEnd('/').ToLowerInvariant();
		if (HttpMethods.IsGet(context.HttpContext.Request.Method) && path is "/api/users/assignable-roles" or "/api/roles/assignable-permissions") {
			var entity = path == "/api/users/assignable-roles" ? "user" : "role";
			if (!user.Permissions.Any(p => p.Code == "*" || p.Code == $"system.{entity}.add" || p.Code == $"system.{entity}.edit"))
				context.Result = new ObjectResult(ApiResponse<object>.Fail(ErrorCodes.Forbidden, "无权执行此操作")) { StatusCode = 403 };
			return;
		}
		if (path == "/api/auth/info" || path == "/api/users/change-password" || (HttpMethods.IsGet(context.HttpContext.Request.Method) && path == "/api/dict/data/all")) return;
		var resource = path.Split('/', StringSplitOptions.RemoveEmptyEntries).Skip(1).FirstOrDefault();
		var permission = resource switch {
			"users" => "system.user.view", "roles" => "system.role.view", "permissions" => "system.permission.view",
			"dept" => "system.dept.view", "dict" => "system.dict.view", "config" => "system.config.view",
			"file" => "system.file.view", "log" => "system.log.view", _ => null
		};
		var action = context.HttpContext.Request.Method switch {
			"GET" or "HEAD" => "view", "POST" => resource == "file" ? "upload" : "add",
			"PUT" or "PATCH" => "edit", "DELETE" => resource == "log" ? "clear" : "delete", _ => "denied"
		};
		if (permission is not null) permission = permission[..^4] + action;
		var allowed = user.Permissions.Any(p => p.Code == "*") ||
			(permission is not null && user.Permissions.Any(p => p.Code == permission));
		// 尚未替换的旧管理入口也必须使用数据库实时角色，避免撤权后 JWT 继续授权。
		if (permission is null) allowed = user.Roles.Any(r => r.Code is "ROLE_ADMIN" or "ROLE_SUPER");
		if (!allowed) context.Result = new ObjectResult(ApiResponse<object>.Fail(ErrorCodes.Forbidden, "无权执行此操作")) { StatusCode = 403 };
	}
}
