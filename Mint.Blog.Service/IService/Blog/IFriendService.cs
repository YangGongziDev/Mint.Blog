using Mint.Blog.Model.Dtos.Blog.Friend;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Friend;

namespace Mint.Blog.Service.IService.Blog;

public interface IFeedMetadataReader {
	Task<FeedMetadata> ReadAsync(string url, CancellationToken cancellationToken = default);
}

public interface IFriendApplicationEvents {
	Task AppliedAsync(long friendId, DateTimeOffset occurredAt, CancellationToken cancellationToken = default);
}

public interface IFriendService {
	Task<PagedResult<AdminFriendPageItemVo>> GetAsync(GetAdminFriendPageListQuery query, CancellationToken cancellationToken = default);
	Task<PagedResult<FriendListItemVo>> GetAsync(GetFriendListQuery query, CancellationToken cancellationToken = default);
	Task<FriendDetailVo?> GetAsync(GetFriendDetailQuery query, CancellationToken cancellationToken = default);
	Task<FeedMetadata> ReadAsync(string url, CancellationToken cancellationToken = default);
	Task<long> ApplyAsync(ApplyFriendCommand command, CancellationToken cancellationToken = default);
	Task<long> CreateAsync(CreateAdminFriendCommand command, CancellationToken cancellationToken = default);
	Task UpdateAsync(UpdateFriendCommand command, CancellationToken cancellationToken = default);
	Task DeleteAsync(DeleteFriendCommand command, CancellationToken cancellationToken = default);
	Task SetTopAsync(SetFriendTopCommand command, CancellationToken cancellationToken = default);
	Task SetStatusAsync(SetFriendStatusCommand command, CancellationToken cancellationToken = default);
	Task UpdateSortAsync(UpdateFriendSortCommand command, CancellationToken cancellationToken = default);
	Task MoveSortFirstAsync(MoveFriendSortFirstCommand command, CancellationToken cancellationToken = default);
	Task MoveSortLastAsync(MoveFriendSortLastCommand command, CancellationToken cancellationToken = default);
}
