using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Mint.Blog.WebApi.Extensions;
using Scalar.AspNetCore;
using Serilog;



var builder = WebApplication.CreateBuilder(args);

// 配置Serilog日志记录
builder.Host.UseSerilog((context, services, configuration) => configuration
	.ReadFrom.Configuration(context.Configuration)
	.ReadFrom.Services(services));

builder.Services.AddWebApi(builder.Configuration);
builder.Services.AddBackend(builder.Configuration);

var app = builder.Build();

app.UseGlobalExceptionHandling();
app.UseHttpLogging();

// app.UseHttpsRedirection();
app.UseAuthentication();
app.UseMiddleware<Mint.Blog.WebApi.Middleware.AdminAuditMiddleware>();
app.UseAuthorization();
app.UseFriendlyForbidden();
app.MapControllers();

if (app.Environment.IsDevelopment()) {
	app.MapOpenApi("/api/openapi/{documentName}.json");
	app.MapScalarApiReference("/api/docs", options => options
		.WithTitle("Mint.Blog API Docs")
		.ForceDarkMode()
		.WithDefaultHttpClient(ScalarTarget.CSharp, ScalarClient.HttpClient)
		.WithSearchHotKey("p")
		.AddDocument("v1", "Mint.Blog Web API", "/api/openapi/v1.json", true)
		.DisableDefaultFonts()
	);
}
app.MapHealthChecks("/api/health", new HealthCheckOptions {
	ResponseWriter = async (context, report) => {
		context.Response.ContentType = "application/json";
		await context.Response.WriteAsJsonAsync(new {
			name = "Mint.Blog.Api",
			status = report.Status.ToString().ToLowerInvariant(),
			totalDuration = report.TotalDuration.TotalMilliseconds,
			entries = report.Entries.ToDictionary(
				x => x.Key,
				x => new {
					status = x.Value.Status.ToString().ToLowerInvariant(),
					duration = x.Value.Duration.TotalMilliseconds,
					description = x.Value.Description
				})
		});
	}
});

app.Run();

public partial class Program;
