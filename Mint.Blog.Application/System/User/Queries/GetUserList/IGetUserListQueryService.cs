using Mint.Blog.Application.System.Dtos;

namespace Mint.Blog.Application.System.User.Queries.GetUserList;

public interface IGetUserListQueryService
{
    Task<PaginatedListDto<UserDto>> GetAsync(GetUserListQuery query, CancellationToken cancellationToken = default);
}
