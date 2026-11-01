using Mint.Blog.Api.Middleware;

namespace Mint.Blog.Api.Extensions;

public static class ApplicationBuilderExtensions {
	public static IApplicationBuilder UseGlobalExceptionHandling(this IApplicationBuilder app){
		return app.UseMiddleware<GlobalExceptionMiddleware>();
	}

	public static IApplicationBuilder UseFriendlyForbidden(this IApplicationBuilder app){
		return app.UseMiddleware<FriendlyForbiddenMiddleware>();
	}
}