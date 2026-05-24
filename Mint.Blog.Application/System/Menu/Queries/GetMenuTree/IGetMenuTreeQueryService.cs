using SystemMenuTreeDto = Mint.Blog.Application.System.Menu.Dtos.MenuTreeDto;

namespace Mint.Blog.Application.System.Menu.Queries.GetMenuTree;

public interface IGetMenuTreeQueryService
{
    Task<IReadOnlyCollection<SystemMenuTreeDto>> GetAsync(CancellationToken cancellationToken = default);
}
