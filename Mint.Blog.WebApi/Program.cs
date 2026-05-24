using BCrypt.Net;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Mint.Blog.Infrastructure.DependencyInjection;
using Mint.Blog.WebApi.Extensions;
using Scalar.AspNetCore;



var builder = WebApplication.CreateBuilder(args);

builder.Services.AddWebApi(builder.Configuration);
builder.Services.AddInfrastructure(builder.Configuration);

PrintTemporaryPasswordHash(builder.Configuration, builder.Environment);

var app = builder.Build();

app.UseGlobalExceptionHandling();
app.UseHttpLogging();

if (app.Environment.IsDevelopment()) {
	app.MapOpenApi();
	app.MapScalarApiReference("/docs", options => options
		.WithTitle("Mint.Blog API Docs")
		.ForceDarkMode()
		.WithDefaultHttpClient(ScalarTarget.CSharp, ScalarClient.HttpClient)
		.WithSearchHotKey("p")
		.AddDocument("v1", "Mint.Blog Web API", "/openapi/v1.json", true)
		.DisableDefaultFonts()
	);
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.UseFriendlyForbidden();
app.MapControllers();

app.MapHealthChecks("/health", new HealthCheckOptions {
	ResponseWriter = async (context, report) => {
		context.Response.ContentType = "application/json";
		await context.Response.WriteAsJsonAsync(new {
			name = "Mint.Blog.WebApi",
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

static void PrintTemporaryPasswordHash(IConfiguration configuration, IWebHostEnvironment environment){
	if (!environment.IsDevelopment()) return;

	var enabled = configuration.GetValue<bool>("DevPasswordTools:Enabled");
	var password = configuration["DevPasswordTools:PrintPassword"];

	if (!enabled || string.IsNullOrWhiteSpace(password)) return;

	var hash = BCrypt.Net.BCrypt.HashPassword(password.Trim(), 12);
	Console.WriteLine($"[DevPasswordTools] Password: {password}");
	Console.WriteLine($"[DevPasswordTools] BCrypt Hash: {hash}");
}

public partial class Program;