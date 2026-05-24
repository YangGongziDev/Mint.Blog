using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagList;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/tag")]
public sealed class TagController(IGetTagListQueryService tagListQueryService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<TagListItemDto>>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<IReadOnlyCollection<TagListItemDto>>>> Get(
		CancellationToken cancellationToken){
		var tags = await tagListQueryService.GetAsync(cancellationToken);
		return Ok(ApiResponse<IReadOnlyCollection<TagListItemDto>>.Ok(tags));
	}
}