using Mint.Blog.Application.System.Dtos;
using Mint.Blog.Application.System.Menu.Queries.GetAllPages;
using Mint.Blog.Application.System.Menu.Queries.GetMenuList;
using Mint.Blog.Application.System.Menu.Queries.GetMenuTree;
using SystemMenuDto = Mint.Blog.Application.System.Menu.Dtos.MenuDto;
using SystemMenuTreeDto = Mint.Blog.Application.System.Menu.Dtos.MenuTreeDto;

namespace Mint.Blog.Infrastructure.System.Menu;

public sealed class MenuQueryService :
    IGetAllPagesQueryService,
    IGetMenuListQueryService,
    IGetMenuTreeQueryService
{
    Task<IReadOnlyCollection<string>> IGetAllPagesQueryService.GetAsync(CancellationToken cancellationToken)
    {
        return Task.FromResult<IReadOnlyCollection<string>>([]);
    }

    Task<IReadOnlyCollection<SystemMenuTreeDto>> IGetMenuTreeQueryService.GetAsync(CancellationToken cancellationToken)
    {
        return Task.FromResult<IReadOnlyCollection<SystemMenuTreeDto>>([]);
    }

    public Task<PaginatedListDto<SystemMenuDto>> GetAsync(
        GetMenuListQuery query,
        CancellationToken cancellationToken = default)
    {
        var result = new PaginatedListDto<SystemMenuDto>
        {
            Current = query.Current,
            Size = query.Size,
            Total = 0,
            Records = []
        };

        return Task.FromResult(result);
    }
}
