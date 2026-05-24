using Mint.Blog.Application.System.Dtos;
using Mint.Blog.Application.System.Role.Queries.GetAllRoles;
using Mint.Blog.Application.System.Role.Queries.GetRoleList;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;
using SystemRoleDto = Mint.Blog.Application.System.Role.Dtos.RoleDto;

namespace Mint.Blog.Infrastructure.System.Role;

public sealed class RoleQueryService(ISqlSugarDbContext dbContext) :
    IGetAllRolesQueryService,
    IGetRoleListQueryService
{
    public async Task<IReadOnlyCollection<SystemRoleDto>> GetAsync(CancellationToken cancellationToken = default)
    {
        var roleNames = await dbContext.Client.Queryable<UserRoleDataModel>()
            .GroupBy(x => x.Role)
            .Select(x => new
            {
                Id = SqlSugar.SqlFunc.AggregateMin(x.Id),
                Role = x.Role,
                CreatedAt = SqlSugar.SqlFunc.AggregateMin(x.CreatedAt)
            })
            .ToListAsync(cancellationToken);

        return roleNames
            .Select(item => new SystemRoleDto
            {
                Id = item.Id,
                UserName = string.Empty,
                Role = item.Role,
                CreateTime = item.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss")
            })
            .ToArray();
    }

    public async Task<PaginatedListDto<SystemRoleDto>> GetAsync(
        GetRoleListQuery query,
        CancellationToken cancellationToken = default)
    {
        var current = query.Current <= 0 ? 1 : query.Current;
        var size = query.Size <= 0 ? 10 : query.Size;
        var skip = (current - 1) * size;

        var roleQueryable = dbContext.Client.Queryable<UserRoleDataModel>();

        if (!string.IsNullOrWhiteSpace(query.UserName))
            roleQueryable = roleQueryable.Where(x => x.UserName.Contains(query.UserName));

        if (!string.IsNullOrWhiteSpace(query.Role))
            roleQueryable = roleQueryable.Where(x => x.Role.Contains(query.Role));

        var total = await roleQueryable.CountAsync();
        var roles = await roleQueryable
            .OrderByDescending(x => x.CreatedAt)
            .Skip(skip)
            .Take(size)
            .ToListAsync(cancellationToken);

        var records = roles
            .Select(item => new SystemRoleDto
            {
                Id = item.Id,
                UserName = item.UserName,
                Role = item.Role,
                CreateTime = item.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss")
            })
            .ToList();

        return new PaginatedListDto<SystemRoleDto>
        {
            Current = current,
            Size = size,
            Total = total,
            Records = records
        };
    }
}
