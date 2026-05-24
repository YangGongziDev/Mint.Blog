namespace Mint.Blog.Application.System.User.Queries.GetSystemUserInfo;

public interface IGetSystemUserInfoQueryService {
	Task<SystemUserInfoDto?> GetAsync(string userName, CancellationToken cancellationToken = default);
}
