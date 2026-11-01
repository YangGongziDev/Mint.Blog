using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.HttpLogging;
using Microsoft.IdentityModel.Tokens;
using Mint.Blog.WebApi.Json;
using Mint.Blog.WebApi.Middleware;
using Mint.Blog.Model.Options;

namespace Mint.Blog.WebApi.Extensions;

public static class ServiceCollectionExtensions {
	public static IServiceCollection AddWebApi(this IServiceCollection services, IConfiguration configuration){
		var jwtOptions = configuration.GetSection(JwtOptions.SectionName).Get<JwtOptions>() ?? new JwtOptions();

		services.AddControllers(options => options.Filters.Add<AdminPermissionFilter>())
			.ConfigureApiBehaviorOptions(options => options.InvalidModelStateResponseFactory = context =>
				new Microsoft.AspNetCore.Mvc.BadRequestObjectResult(ApiResponse<object>.Fail("validation_error", "请求参数无效")))
			.AddJsonOptions(options => {
				options.JsonSerializerOptions.Converters.Add(new LongToStringJsonConverter());
				options.JsonSerializerOptions.Converters.Add(new NullableLongToStringJsonConverter());
			});
		services.AddEndpointsApiExplorer();
		// 配置OpenAPI文档，根据路径分组
		services.AddOpenApi(options => options.AddDocumentTransformer((document, context, cancellationToken) => {
			document.Tags = new HashSet<Microsoft.OpenApi.OpenApiTag> {
				new() { Name = "system" },
				new() { Name = "admin" },
				new() { Name = "surfer" }
			};
			foreach (var (path, item) in document.Paths) {
				var group = path.Split('/').ElementAtOrDefault(2);
				if (group is not ("system" or "admin" or "surfer")) continue;
				if (item.Operations is null) continue;
				foreach (var operation in item.Operations.Values)
					operation.Tags = new HashSet<Microsoft.OpenApi.OpenApiTagReference> {
						new(group, document)
					};
			}
			return Task.CompletedTask;
		}));
		services.AddHttpLogging(options => {
			options.LoggingFields = HttpLoggingFields.RequestMethod
			                        | HttpLoggingFields.RequestPath
			                        | HttpLoggingFields.ResponseStatusCode
			                        | HttpLoggingFields.Duration;
		});
		services.AddHealthChecks();

		if (!string.IsNullOrWhiteSpace(jwtOptions.SecurityKey))
			services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
				.AddJwtBearer(options => {
					options.TokenValidationParameters = new TokenValidationParameters {
						ValidateIssuer = true,
						ValidateAudience = true,
						ValidateIssuerSigningKey = true,
						ValidateLifetime = true,
						ValidIssuer = jwtOptions.Issuer,
						ValidAudience = jwtOptions.Audience,
						IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtOptions.SecurityKey)),
						ClockSkew = TimeSpan.Zero
					};
					options.Events = new JwtBearerEvents {
						OnChallenge = async context => {
							context.HandleResponse();
							context.Response.StatusCode = StatusCodes.Status401Unauthorized;
							context.Response.ContentType = "application/json";

							var isExpired = context.AuthenticateFailure is SecurityTokenExpiredException;
							var errorCode = isExpired ? ErrorCodes.TokenExpired : ErrorCodes.Unauthorized;
							var message = isExpired ? "登录已过期，请重新登录。" : "未登录或登录状态无效。";

							await context.Response.WriteAsJsonAsync(ApiResponse<object>.Fail(errorCode, message));
						}
					};
				});

		services.AddAuthorization();

		return services;
	}
}
