using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.WebApi.Middleware;

public sealed class FriendlyForbiddenMiddleware(RequestDelegate next) {
	public async Task InvokeAsync(HttpContext context) {
		await next(context);

		if (context.Response.StatusCode == StatusCodes.Status403Forbidden
			&& !context.Response.HasStarted
			&& context.Response.ContentType?.StartsWith("application/json") != true) {
			context.Response.ContentType = "application/json";
			context.Response.StatusCode = StatusCodes.Status403Forbidden;
			await context.Response.WriteAsJsonAsync(
				ApiResponse<object>.Fail(ErrorCodes.Forbidden, "当前账号没有执行此操作的权限。"));
		}
	}
}
