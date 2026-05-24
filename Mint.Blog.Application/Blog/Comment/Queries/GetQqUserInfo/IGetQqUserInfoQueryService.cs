namespace Mint.Blog.Application.Blog.Comment.Queries.GetQqUserInfo;

public interface IGetQqUserInfoQueryService {
	Task<QqUserInfoDto?> GetAsync(GetQqUserInfoQuery query, CancellationToken cancellationToken = default);
}