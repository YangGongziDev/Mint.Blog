using Mint.Blog.Common.Responses;
using Npgsql;

namespace Mint.Blog.WebApi.Middleware;

public sealed class GlobalExceptionMiddleware(RequestDelegate next, ILogger<GlobalExceptionMiddleware> logger) {
	public async Task InvokeAsync(HttpContext context){
		try {
			await next(context);
		} catch (BusinessException exception) {
			var response = ApiResponse<object>.Fail(exception.ErrorCode, exception.Message);
			context.Response.StatusCode = response.Code;
			await context.Response.WriteAsJsonAsync(response);
		} catch (Exception exception) when (ConflictMessage(exception) is not null) {
			context.Response.StatusCode = StatusCodes.Status409Conflict;
			await context.Response.WriteAsJsonAsync(ApiResponse<object>.Fail("data_conflict", ConflictMessage(exception)!));
		} catch (Exception exception) {
			logger.LogError(exception, "Unhandled exception occurred while processing request.");
			context.Response.StatusCode = StatusCodes.Status500InternalServerError;
			await context.Response.WriteAsJsonAsync(ApiResponse<object>.Fail(ErrorCodes.InternalServerError, "Internal server error"));
		}
	}

	private static string? ConflictMessage(Exception exception){
		for (Exception? current = exception; current is not null; current = current.InnerException) {
			if (current is not PostgresException { SqlState: PostgresErrorCodes.UniqueViolation } postgres) continue;
			return postgres.ConstraintName switch {
				"uk_name" => "分类名称已存在（包括已删除分类），请恢复或编辑原记录。",
				"uk_name_tag" => "标签名称已存在（包括已删除标签），请恢复或编辑原记录。",
				"uq_blog_tag_version_name" => "该标签下版本名称已存在（包括已删除版本）。",
				"uq_blog_tag_version_general" => "该标签已有通用版本，请刷新后重试。",
				"uq_blog_resource_tag_version_url" => "该标签和版本下资源地址已存在（包括已删除资源），请恢复或编辑原记录。",
				_ => null
			};
		}
		return null;
	}
}
