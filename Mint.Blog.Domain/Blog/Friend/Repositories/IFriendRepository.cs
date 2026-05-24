using FriendEntity = Mint.Blog.Domain.Blog.Friend.Entities.Friend;
namespace Mint.Blog.Domain.Blog.Friend.Repositories;

public interface IFriendRepository {
	Task<long> AddAsync(FriendEntity friend, CancellationToken cancellationToken = default);
	Task<FriendEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default);
	Task<FriendEntity?> GetByIdIncludingDeletedAsync(long id, CancellationToken cancellationToken = default);
	Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default);
	Task UpdateAsync(FriendEntity friend, CancellationToken cancellationToken = default);
	Task<int> GetMaxSortAsync(CancellationToken cancellationToken = default);
	Task<int?> GetMinSortAsync(CancellationToken cancellationToken = default);
	Task DeleteAsync(long id, CancellationToken cancellationToken = default);
}
