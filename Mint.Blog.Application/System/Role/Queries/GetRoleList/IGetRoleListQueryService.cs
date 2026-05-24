using Mint.Blog.Application.System.Dtos;
using SystemRoleDto = Mint.Blog.Application.System.Role.Dtos.RoleDto;

namespace Mint.Blog.Application.System.Role.Queries.GetRoleList;

public interface IGetRoleListQueryService
{
    Task<PaginatedListDto<SystemRoleDto>> GetAsync(
        GetRoleListQuery query,
        CancellationToken cancellationToken = default);
}
