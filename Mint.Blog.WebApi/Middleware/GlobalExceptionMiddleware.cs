using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.WebApi.Middleware;

public sealed class GlobalExceptionMiddleware(RequestDelegate next, ILogger<GlobalExceptionMiddleware> logger) {
	public async Task InvokeAsync(HttpContext context){
		try {
			await next(context);
		} catch (BusinessException exception) {
			var response = ApiResponse<object>.Fail(exception.ErrorCode, exception.Message);
			context.Response.StatusCode = response.Code;
			await context.Response.WriteAsJsonAsync(response);
		} catch (Exception exception) {
			logger.LogError(exception, "Unhandled exception occurred while processing request.");
			context.Response.StatusCode = StatusCodes.Status500InternalServerError;
			await context.Response.WriteAsJsonAsync(ApiResponse<object>.Fail(ErrorCodes.InternalServerError, "Internal server error"));
		}
	}
}
