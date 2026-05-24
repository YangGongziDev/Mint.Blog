using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Role.Commands.UpdateUserRole;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;

namespace Mint.Blog.Infrastructure.System.Role;

public sealed class UpdateUserRoleCommandHandler(ISqlSugarDbContext dbContext)
{
    public async Task HandleAsync(UpdateUserRoleCommand command, CancellationToken cancellationToken = default)
    {
        Guard.Against(command.Id <= 0, ErrorCodes.UserNotFound, "User role id is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.UserName), ErrorCodes.UserNotFound, "User name is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.Role), ErrorCodes.UserNotFound, "Role is required.");

        var exists = await dbContext.Client.Queryable<UserRoleDataModel>()
            .AnyAsync(x => x.Id == command.Id, cancellationToken);
        Guard.Against(!exists, ErrorCodes.UserNotFound, "User role does not exist.");

        await dbContext.Client.Updateable<UserRoleDataModel>()
            .SetColumns(x => new UserRoleDataModel
            {
                UserName = command.UserName.Trim(),
                Role = command.Role.Trim()
            })
            .Where(x => x.Id == command.Id)
            .ExecuteCommandAsync(cancellationToken);
    }
}
