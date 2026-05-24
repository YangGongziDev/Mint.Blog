namespace Mint.Blog.Application.Blog.Friend.Queries.GetFriendDetail;

public interface IGetFriendDetailQueryService {
	Task<FriendDetailDto?> GetAsync(GetFriendDetailQuery query, CancellationToken cancellationToken = default);
}