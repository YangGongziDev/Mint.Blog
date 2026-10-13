using System.Text.Json.Nodes;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Auth;

namespace Mint.Blog.WebApi.Controllers.System;

[ApiController]
[Authorize]
[Route("api")]
public sealed class AdminRbacController(IAdminRbacService service) : ControllerBase {
	[HttpGet("users")]
	[HttpGet("roles")]
	[HttpGet("permissions")]
	[HttpGet("users/{id:long}")]
	[HttpGet("roles/{id:long}")]
	[HttpGet("permissions/{id:long}")]
	public async Task<IActionResult> Read(long? id) => Ok(ApiResponse<object>.Ok(await service.ReadAsync(Resource(), id, Request.Query.ToDictionary(k => k.Key, v => v.Value.ToString()))));
	[HttpGet("users/assignable-roles")]
	[HttpGet("roles/assignable-permissions")]
	public async Task<IActionResult> Assignable() => Ok(ApiResponse<object>.Ok(await service.AssignableAsync(Resource(), User.Identity!.Name!)));
	[HttpPost("users")]
	[HttpPost("roles")]
	[HttpPost("permissions")]
	[HttpPut("users/{id:long}")]
	[HttpPut("roles/{id:long}")]
	[HttpPut("permissions/{id:long}")]
	public async Task<IActionResult> Save(long? id, [FromBody] JsonObject input) => Ok(ApiResponse<object>.Ok(await service.WriteAsync(Resource(), id, input, User.Identity!.Name!)));
	[HttpDelete("users/{id:long}")]
	[HttpDelete("roles/{id:long}")]
	[HttpDelete("permissions/{id:long}")]
	public async Task<IActionResult> Delete(long id) => Ok(ApiResponse<object>.Ok(await service.WriteAsync(Resource(), id, null, User.Identity!.Name!, true)));
	private string Resource() => Request.Path.Value!.Split('/', StringSplitOptions.RemoveEmptyEntries)[1];
}
