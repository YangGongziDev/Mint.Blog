using Mint.Blog.Model.Dtos.Blog.Friend;
using Mint.Blog.Model.Entitys.Blog.Friend;
using Mint.Blog.Model.Vos;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using SqlSugar;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class FriendRepository(ISqlSugarDbContext dbContext) : IFriendRepository {
	public async Task<long> AddAsync(FriendDataModel friend, CancellationToken cancellationToken = default) =>
		await dbContext.Client.Insertable(friend).ExecuteReturnIdentityAsync(cancellationToken);

	public async Task<FriendDataModel?> GetByIdAsync(long id, bool includingDeleted = false, CancellationToken cancellationToken = default) =>
		await dbContext.Client.Queryable<FriendDataModel>().Where(x => x.Id == id)
			.WhereIF(!includingDeleted, x => x.IsDeleted == 0).SingleAsync();

	public Task UpdateAsync(FriendDataModel friend, CancellationToken cancellationToken = default) =>
		dbContext.Client.Updateable<FriendDataModel>().SetColumns(x => new FriendDataModel {
			Name = friend.Name, Avatar = friend.Avatar, Category = friend.Category, Url = friend.Url,
			RssUrl = friend.RssUrl, Description = friend.Description, Email = friend.Email,
			Status = friend.Status, IsTop = friend.IsTop, Sort = friend.Sort,
			IsDeleted = friend.IsDeleted, UpdatedAt = friend.UpdatedAt
		}).Where(x => x.Id == friend.Id).ExecuteCommandAsync(cancellationToken);

	public async Task DeleteAsync(long id, CancellationToken cancellationToken = default) =>
		await dbContext.Client.Deleteable<FriendDataModel>().Where(x => x.Id == id).ExecuteCommandAsync(cancellationToken);

	public Task UpdateSortAsync(long id, int sort, CancellationToken cancellationToken = default) =>
		dbContext.Client.Updateable<FriendDataModel>()
			.SetColumns(x => new FriendDataModel { Sort = sort, UpdatedAt = DateTimeOffset.UtcNow })
			.Where(x => x.Id == id).ExecuteCommandAsync(cancellationToken);

	public async Task<bool> MoveAsync(long id, string move, CancellationToken cancellationToken = default){
		await dbContext.Client.Ado.ExecuteCommandAsync("LOCK TABLE blog_friend IN SHARE ROW EXCLUSIVE MODE");
		var friends = await dbContext.Client.Queryable<FriendDataModel>()
			.OrderByDescending(x => x.IsTop)
			.OrderBy(x => SqlFunc.IsNull(x.Sort, 0)).OrderBy(x => x.Id).ToListAsync(cancellationToken);
		var index = friends.FindIndex(x => x.Id == id);
		if (index < 0) return false;
		var friend = friends[index];
		var first = friends.FindIndex(x => x.IsTop == friend.IsTop);
		var last = friends.FindLastIndex(x => x.IsTop == friend.IsTop);
		var target = move switch {
			"up" => Math.Max(first, index - 1),
			"down" => Math.Min(last, index + 1),
			"first" => first,
			"last" => last,
			_ => throw new ArgumentOutOfRangeException(nameof(move), "Unsupported move direction.")
		};
		friends.RemoveAt(index);
		friends.Insert(target, friend);
		var now = DateTimeOffset.UtcNow;
		for (var i = 0; i < friends.Count; i++) {
			friends[i].Sort = i + 1;
			friends[i].UpdatedAt = now;
		}
		await dbContext.Client.Updateable(friends).UpdateColumns(x => new { x.Sort, x.UpdatedAt }).ExecuteCommandAsync(cancellationToken);
		return true;
	}

	public async Task<int> GetMaxSortAsync(CancellationToken cancellationToken = default) =>
		(await dbContext.Client.Queryable<FriendDataModel>().OrderByDescending(x => x.Sort).FirstAsync(cancellationToken))?.Sort ?? 0;
	public async Task<int?> GetMinSortAsync(CancellationToken cancellationToken = default) =>
		(await dbContext.Client.Queryable<FriendDataModel>().OrderBy(x => x.Sort).FirstAsync(cancellationToken))?.Sort;

	public async Task<PagedResult<FriendDataModel>> GetAsync(GetAdminFriendPageListQuery query, CancellationToken cancellationToken = default){
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var rows = dbContext.Client.Queryable<FriendDataModel>();
		if (!string.IsNullOrWhiteSpace(query.Name)) {
			var keyword = query.Name.Trim();
			rows = rows.Where(x => x.Name.Contains(keyword));
		}
		if (query.StartDate.HasValue) {
			var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			rows = rows.Where(x => x.CreatedAt >= start);
		}
		if (query.EndDate.HasValue) {
			var endExclusive = query.EndDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			rows = rows.Where(x => x.CreatedAt < endExclusive);
		}
		var count = await rows.CountAsync(cancellationToken);
		var ordered = query.SortOrder?.ToLowerInvariant() switch {
			"timeasc" => rows.OrderBy(x => x.CreatedAt).OrderBy(x => SqlFunc.IsNull(x.Sort, 0)).OrderBy(x => x.Id),
			"timedesc" => rows.OrderByDescending(x => x.CreatedAt).OrderBy(x => SqlFunc.IsNull(x.Sort, 0)).OrderBy(x => x.Id),
			_ => rows.OrderByDescending(x => x.IsTop).OrderBy(x => SqlFunc.IsNull(x.Sort, 0)).OrderBy(x => x.Id)
		};
		var items = await ordered.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken);
		return new(items, pageNumber, pageSize, count);
	}

	public async Task<PagedResult<FriendDataModel>> GetAsync(GetFriendListQuery query, CancellationToken cancellationToken = default){
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var rows = dbContext.Client.Queryable<FriendDataModel>().Where(x => x.IsDeleted == 0);
		var count = await rows.CountAsync(cancellationToken);
		var items = await rows.OrderByDescending(x => x.IsTop).OrderBy(x => SqlFunc.IsNull(x.Sort, 0))
			.OrderBy(x => x.Id).Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken);
		return new(items, pageNumber, pageSize, count);
	}
}
