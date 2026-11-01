using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Resource;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[AllowAnonymous]
[Route("api/surfer")]
public sealed class ResourceController(IResourceService queries) : ControllerBase {
	[HttpGet("navigation-tags")]
	public async Task<IActionResult> NavigationTags([FromQuery] long? categoryId, [FromQuery] string? keyword, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(await queries.GetNavigationTagsAsync(true, categoryId, keyword, ct)));
	[HttpGet("tags/{tagId:long}/versions")]
	public async Task<IActionResult> Versions(long tagId, CancellationToken ct) =>
		Ok(ApiResponse<object>.Ok(await queries.GetVersionsAsync(tagId, true, ct)));
	[HttpGet("tags/{tagId:long}/articles")]
	public async Task<IActionResult> Articles(long tagId, [FromQuery] NavigationArticleQuery query, CancellationToken ct) {
		RejectLegacyQuery();
		return Ok(ApiResponse<object>.Ok(await queries.GetArticlesAsync(tagId, query, ct)));
	}
	[HttpGet("resources")]
	public async Task<IActionResult> Resources([FromQuery] ResourcePageQuery query, CancellationToken ct) {
		RejectLegacyQuery();
		return Ok(ApiResponse<object>.Ok(await queries.GetResourcesAsync(query, true, ct)));
	}
	private void RejectLegacyQuery() => Guard.Against(Request.Query.ContainsKey("versionId"),
		"legacy_contract", "请升级客户端，版本筛选参数已改为 tagVersionId。");
}
