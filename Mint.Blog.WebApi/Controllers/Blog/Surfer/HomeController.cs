using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Queries.GetBlogHome;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/blog/surfer/home")]
public sealed class HomeController(IGetBlogHomeQueryService blogHomeQueryService) : ControllerBase {
	[HttpGet]
	[ProducesResponseType(typeof(ApiResponse<BlogHomeDto>), StatusCodes.Status200OK)]
	public async Task<ActionResult<ApiResponse<BlogHomeDto>>> Get(
		[FromQuery] int latestArticleCount = 8,
		[FromQuery] int hotArticleCount = 8,
		[FromQuery] int topArticleCount = 5,
		CancellationToken cancellationToken = default){
		var query = new BlogHomeQuery(latestArticleCount, hotArticleCount, topArticleCount);
		var result = await blogHomeQueryService.GetAsync(query, cancellationToken);
		return Ok(ApiResponse<BlogHomeDto>.Ok(result));
	}
}