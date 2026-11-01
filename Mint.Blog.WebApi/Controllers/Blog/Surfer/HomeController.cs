using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Common.Responses;
using Mint.Blog.Model.Dtos.Blog.Article;
using Mint.Blog.Model.Vos.Blog.Article;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[Route("api/surfer/home")]
public sealed class HomeController(IPublicArticleService service) : ControllerBase {
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<BlogHomeDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<BlogHomeDto>>> Get(
        [FromQuery] int latestArticleCount = 8,
        [FromQuery] int hotArticleCount = 8,
        [FromQuery] int topArticleCount = 5,
        CancellationToken cancellationToken = default) {
        var query = new BlogHomeQuery(latestArticleCount, hotArticleCount, topArticleCount);
        var result = await service.GetHomeAsync(query, cancellationToken);
        return Ok(ApiResponse<BlogHomeDto>.Ok(result));
    }
}
