using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.HttpLogging;
using Microsoft.IdentityModel.Tokens;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Options;
using Mint.Blog.WebApi.Json;
using Mint.Blog.WebApi.Middleware;

namespace Mint.Blog.WebApi.Extensions;

public static class ServiceCollectionExtensions {
	public static IServiceCollection AddWebApi(this IServiceCollection services, IConfiguration configuration){
		var jwtOptions = configuration.GetSection(JwtOptions.SectionName).Get<JwtOptions>() ?? new JwtOptions();

		services.AddControllers()
			.AddJsonOptions(options => {
				options.JsonSerializerOptions.Converters.Add(new LongToStringJsonConverter());
				options.JsonSerializerOptions.Converters.Add(new NullableLongToStringJsonConverter());
			});
		services.AddEndpointsApiExplorer();
		services.AddOpenApi();
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
