using System.Text.Json.Nodes;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Auth;

namespace Mint.Blog.WebApi.Controllers.System;

[ApiController]
[Authorize]
[Route("api")]
public sealed class AdminModulesController(IAdminModuleService service) : ControllerBase {
	[HttpGet("dept/tree")]
	[HttpGet("dept/list")]
	[HttpGet("dict/types")]
	[HttpGet("dict/type/list")]
	[HttpGet("dict/data/list")]
	[HttpGet("dict/data/all")]
	[HttpGet("dict/data/{key}")]
	[HttpGet("config/list")]
	[HttpGet("config/key/{key}")]
	[HttpGet("file/list")]
	[HttpGet("log/operation/list")]
	[HttpGet("log/login/list")]
	public async Task<IActionResult> Read([FromRoute] string? key){
		var parts = Parts();
		var mode = parts[^1] switch { "tree" => "tree", "types" or "all" => "all", _ => key is null ? "list" : parts[0] == "config" ? "key" : "byType" };
		return Ok(ApiResponse<object>.Ok(await service.ReadAsync(Resource(), mode, key, Request.Query.ToDictionary(k => k.Key, v => v.Value.ToString()))));
	}
	[HttpPost("dept")]
	[HttpPost("dict/type")]
	[HttpPost("dict/data")]
	[HttpPost("config")]
	[HttpPut("dept/{id:long}")]
	[HttpPut("dict/type/{id:long}")]
	[HttpPut("dict/data/{id:long}")]
	[HttpPut("config/{id:long}")]
	public async Task<IActionResult> Save([FromRoute] long? id, [FromBody] JsonObject input) => Ok(ApiResponse<object>.Ok(await service.SaveAsync(Resource(), id, input)));
	[HttpDelete("dept/{id:long}")]
	[HttpDelete("dict/type/{id:long}")]
	[HttpDelete("dict/data/{id:long}")]
	[HttpDelete("config/{id:long}")]
	[HttpDelete("file/{id:long}")]
	public async Task<IActionResult> Delete(long id) => Ok(ApiResponse<object>.Ok(await service.SaveAsync(Resource(), id, new JsonObject(), true)));
	[HttpDelete("log/operation/clear")]
	[HttpDelete("log/login/clear")]
	public async Task<IActionResult> Clear(){
		await service.ClearLogsAsync(Resource());
		return Ok(ApiResponse<object>.Ok(null));
	}
	[HttpPost("file/upload")]
	[RequestSizeLimit(21 * 1024 * 1024)]
	public async Task<IActionResult> Upload(IFormFile? file, CancellationToken cancellationToken){
		if (file is null) throw new BusinessException("VALIDATION_ERROR", "请选择上传文件");
		await using var stream = file.OpenReadStream();
		return Ok(ApiResponse<object>.Ok(await service.UploadAsync(stream, file.Length, file.FileName, file.ContentType, User.Identity!.Name!, cancellationToken)));
	}
	private string[] Parts() => Request.Path.Value!.Split('/', StringSplitOptions.RemoveEmptyEntries).Skip(1).ToArray();
	private string Resource(){
		var parts = Parts();
		return parts[0] switch { "dict" => parts[1] is "type" or "types" ? "dictType" : "dictData", "log" => parts[1] == "login" ? "loginLog" : "operationLog", _ => parts[0] };
	}
}
