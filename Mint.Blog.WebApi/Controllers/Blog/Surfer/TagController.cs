using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Vos.Blog.Tag;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/tag")]
public sealed class TagController(ITagService tagListQueryService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<TagListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<TagListItemDto>>>> Get(
		CancellationToken cancellationToken){
		var tags = await tagListQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<TagListItemDto>>.Ok(tags));
	}
}