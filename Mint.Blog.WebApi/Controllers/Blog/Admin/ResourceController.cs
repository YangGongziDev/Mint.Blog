using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Resource;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Admin;

[ApiController]
[Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
[Route("api/admin")]
public sealed class ResourceController(IResourceService queries, IResourceService commands) : ControllerBase {
	[HttpGet("navigation-tags")]
	public async Task<IActionResult> NavigationTags([FromQuery] long? categoryId, [FromQuery] string? keyword, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(await queries.GetNavigationTagsAsync(false, categoryId, keyword, ct)));
	[HttpPatch("navigation-tags/{tagId:long}")]
	public async Task<IActionResult> ConfigureNavigation(long tagId, [FromBody] ConfigureNavigationTagCommand command, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.ConfigureNavigationAsync(tagId, command, ct) }));
	[HttpGet("tags/{tagId:long}/versions")]
	public async Task<IActionResult> Versions(long tagId, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(await queries.GetVersionsAsync(tagId, false, ct)));
	[HttpPost("tags/{tagId:long}/versions")]
	public async Task<IActionResult> CreateVersion(long tagId, [FromBody] SaveTagVersionCommand command, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.SaveVersionAsync(tagId, null, command, ct) }));
	[HttpPut("tags/{tagId:long}/versions/{versionId:long}")]
	public async Task<IActionResult> UpdateVersion(long tagId, long versionId, [FromBody] SaveTagVersionCommand command, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.SaveVersionAsync(tagId, versionId, command, ct) }));
	[HttpDelete("tags/{tagId:long}/versions/{versionId:long}")]
	public async Task<IActionResult> DeleteVersion(long tagId, long versionId, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.DeleteVersionAsync(tagId, versionId, ct) }));
	[HttpGet("resources")]
	public async Task<IActionResult> Resources([FromQuery] ResourcePageQuery query, CancellationToken ct) {
		Guard.Against(Request.Query.ContainsKey("versionId"), "legacy_contract", "请升级客户端，版本筛选参数已改为 tagVersionId。");
		return Ok(ApiResponse<object>.Ok(await queries.GetResourcesAsync(query, false, ct)));
	}
	[HttpGet("resources/{resourceId:long}")]
	public async Task<IActionResult> Resource(long resourceId, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(await queries.GetResourceAsync(resourceId, ct)));
	[HttpPost("resources")]
	public async Task<IActionResult> CreateResource([FromBody] SaveResourceCommand command, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.SaveResourceAsync(null, command, ct) }));
	[HttpPut("resources/{resourceId:long}")]
	public async Task<IActionResult> UpdateResource(long resourceId, [FromBody] SaveResourceCommand command, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.SaveResourceAsync(resourceId, command, ct) }));
	[HttpDelete("resources/{resourceId:long}")]
	public async Task<IActionResult> DeleteResource(long resourceId, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.DeleteResourceAsync(resourceId, ct) }));
	[HttpPost("resources/{resourceId:long}/restore")]
	public async Task<IActionResult> RestoreResource(long resourceId, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(new { id = await commands.RestoreResourceAsync(resourceId, ct) }));
}
