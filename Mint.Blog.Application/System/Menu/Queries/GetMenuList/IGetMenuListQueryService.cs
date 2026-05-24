using Mint.Blog.Application.System.Dtos;
using SystemMenuDto = Mint.Blog.Application.System.Menu.Dtos.MenuDto;

namespace Mint.Blog.Application.System.Menu.Queries.GetMenuList;

public interface IGetMenuListQueryService
{
    Task<PaginatedListDto<SystemMenuDto>> GetAsync(
        GetMenuListQuery query,
        CancellationToken cancellationToken = default);
}
