using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.WebApi.Middleware;

public sealed class GlobalExceptionMiddleware(RequestDelegate next, ILogger<GlobalExceptionMiddleware> logger) {
	public async Task InvokeAsync(HttpContext context){
		try {
			await next(context);
		} catch (BusinessException exception) {
			context.Response.StatusCode = StatusCodes.Status400BadRequest;
			context.Response.ContentType = "application/json";
			await context.Response.WriteAsJsonAsync(ApiResponse<object>.Fail(exception.ErrorCode, exception.Message));
		} catch (Exception exception) {
			logger.LogError(exception, "Unhandled exception occurred while processing request.");
			context.Response.StatusCode = StatusCodes.Status500InternalServerError;
			context.Response.ContentType = "application/json";
			await context.Response.WriteAsJsonAsync(
				ApiResponse<object>.Fail(ErrorCodes.InternalServerError, "Internal server error"));
		}
	}
}
