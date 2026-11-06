using Mint.Blog.Model.Dtos.Blog.Friend;
using Mint.Blog.Model.Entitys.Blog.Friend;
using Mint.Blog.Model.Vos;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IFriendRepository {
	Task<long> AddAsync(FriendDataModel friend, CancellationToken cancellationToken = default);
	Task<FriendDataModel?> GetByIdAsync(long id, bool includingDeleted = false, CancellationToken cancellationToken = default);
	Task UpdateAsync(FriendDataModel friend, CancellationToken cancellationToken = default);
	Task DeleteAsync(long id, CancellationToken cancellationToken = default);
	Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default);
	Task<bool> MoveAsync(long id, string move, CancellationToken cancellationToken = default);
	Task<int> GetMaxSortAsync(CancellationToken cancellationToken = default);
	Task<int?> GetMinSortAsync(CancellationToken cancellationToken = default);
	Task<PagedResult<FriendDataModel>> GetAsync(GetAdminFriendPageListQuery query, CancellationToken cancellationToken = default);
	Task<PagedResult<FriendDataModel>> GetAsync(GetFriendListQuery query, CancellationToken cancellationToken = default);
}
