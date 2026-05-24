using SystemRoleDto = Mint.Blog.Application.System.Role.Dtos.RoleDto;

namespace Mint.Blog.Application.System.Role.Queries.GetAllRoles;

public interface IGetAllRolesQueryService
{
    Task<IReadOnlyCollection<SystemRoleDto>> GetAsync(CancellationToken cancellationToken = default);
}
