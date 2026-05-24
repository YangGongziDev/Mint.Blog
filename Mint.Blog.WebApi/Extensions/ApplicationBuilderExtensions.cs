using Mint.Blog.WebApi.Middleware;

namespace Mint.Blog.WebApi.Extensions;

public static class ApplicationBuilderExtensions {
	public static IApplicationBuilder UseGlobalExceptionHandling(this IApplicationBuilder app){
		return app.UseMiddleware<GlobalExceptionMiddleware>();
	}

	public static IApplicationBuilder UseFriendlyForbidden(this IApplicationBuilder app){
		return app.UseMiddleware<FriendlyForbiddenMiddleware>();
	}
}