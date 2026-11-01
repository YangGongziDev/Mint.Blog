using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Mint.Blog.Service.IService.System;

namespace Mint.Blog.WebApi.Middleware;

public sealed class AdminPermissionFilter(IAdminIdentityQuery identities) : IAsyncAuthorizationFilter {
	// 仅允许已审核的查询路由；新增 GET 接口在审核前默认拒绝访客访问。
	private static readonly HashSet<string> VisitorReadRoutes = new(StringComparer.OrdinalIgnoreCase) {
		"api/admin/articles", "api/admin/articles/{articleId:long}",
		"api/admin/article-draft", "api/admin/article-draft/{draftId:long}", "api/admin/article-draft/by-article/{articleId:long}",
		"api/admin/column", "api/admin/column/{columnId:long}/catalog",
		"api/admin/category", "api/admin/category/page", "api/admin/tag", "api/admin/tag/page",
		"api/admin/comment", "api/admin/friend", "api/admin/setting",
		"api/admin/gallery/categories", "api/admin/gallery/categories/options", "api/admin/gallery/images",
		"api/admin/dashboard/statistics", "api/admin/dashboard/pv-statistics", "api/admin/dashboard/publish-article-statistics",
		"api/admin/image", "api/admin/image/buckets",
		"api/system/users", "api/system/users/{id:long}", "api/system/roles", "api/system/roles/{id:long}", "api/system/permissions", "api/system/permissions/{id:long}",
		"api/system/dept/tree", "api/system/dept/list", "api/system/dict/types", "api/system/dict/type/list", "api/system/dict/data/list", "api/system/dict/data/all", "api/system/dict/data/{key}",
		"api/system/file/list"
	};

	public async Task OnAuthorizationAsync(AuthorizationFilterContext context){
		var endpoint = context.HttpContext.GetEndpoint();
		if (endpoint?.Metadata.GetMetadata<IAllowAnonymous>() is not null || endpoint?.Metadata.GetMetadata<IAuthorizeData>() is null) return;
		var username = context.HttpContext.User.Identity?.Name;
		if (context.HttpContext.User.Identity?.IsAuthenticated != true || string.IsNullOrEmpty(username)) return;
		var user = await identities.GetAsync(username, context.HttpContext.RequestAborted);
		if (user is null) {
			context.Result = new UnauthorizedObjectResult(ApiResponse<object>.Fail(ErrorCodes.Unauthorized, "账号不存在或已禁用"));
			return;
		}
		var path = (context.HttpContext.Request.Path.Value ?? "").TrimEnd('/').ToLowerInvariant();
		var isGet = HttpMethods.IsGet(context.HttpContext.Request.Method);
		if (user.Roles.Any(r => r.Code == "ROLE_VISITOR") && !user.Roles.Any(r => r.Code is "ROLE_ADMIN" or "ROLE_SUPER")) {
			// 保留认证生命周期接口；访客连自己的密码也不能修改。
			var route = context.ActionDescriptor.AttributeRouteInfo?.Template?.Trim('/');
			if (!(isGet && (path == "/api/system/auth/info" || (route is not null && VisitorReadRoutes.Contains(route)))))
				context.Result = new ObjectResult(ApiResponse<object>.Fail(ErrorCodes.Forbidden, "访客仅可查询")) { StatusCode = 403 };
			return;
		}
		if (isGet && path is "/api/system/users/assignable-roles" or "/api/system/roles/assignable-permissions") {
			var entity = path == "/api/system/users/assignable-roles" ? "user" : "role";
			if (!user.Permissions.Any(p => p.Code == "*" || p.Code == $"system.{entity}.add" || p.Code == $"system.{entity}.edit"))
				context.Result = new ObjectResult(ApiResponse<object>.Fail(ErrorCodes.Forbidden, "无权执行此操作")) { StatusCode = 403 };
			return;
		}
		if (path == "/api/system/auth/info" || path == "/api/system/users/change-password" || (isGet && path == "/api/system/dict/data/all")) return;
		var parts = path.Split('/', StringSplitOptions.RemoveEmptyEntries);
		var resource = parts.Skip(parts.ElementAtOrDefault(1) == "system" ? 2 : 1).FirstOrDefault();
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
