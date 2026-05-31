using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Friend.Queries.GetAdminFriendPageList;
using Mint.Blog.Application.Blog.Friend.Queries.GetFriendDetail;
using Mint.Blog.Application.Blog.Friend.Queries.GetFriendList;
using Mint.Blog.Domain.Blog.Friend.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Friend.Persistence;
using FriendEntity = Mint.Blog.Domain.Blog.Friend.Entities.Friend;

namespace Mint.Blog.Infrastructure.Blog.Friend.Repositories;

public sealed class FriendRepository(ISqlSugarDbContext dbContext)
	: IFriendRepository, IGetFriendListQueryService, IGetFriendDetailQueryService, IGetAdminFriendPageListQueryService {
	public async Task<long> AddAsync(FriendEntity friend, CancellationToken cancellationToken = default){
		var data = new FriendDataModel {
			Name = friend.Name,
			Description = friend.Description,
			Url = friend.Url.Value,
			Avatar = friend.Avatar,
			Status = friend.Status,
			Category = friend.Category,
			IsTop = friend.IsTop,
			Email = friend.Email.Value,
			Sort = friend.Sort,
			IsDeleted = ToDbFlag(friend.IsDeleted),
			CreatedAt = friend.CreatedAt,
			UpdatedAt = friend.UpdatedAt
		};

		return await dbContext.Client.Insertable(data).ExecuteReturnIdentityAsync(cancellationToken);
	}

	public Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default){
		return dbContext.Client.Queryable<FriendDataModel>()
			.AnyAsync(x => x.Id == id, cancellationToken);
	}

	public async Task<FriendEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<FriendDataModel>()
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task<FriendEntity?> GetByIdIncludingDeletedAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<FriendDataModel>()
			.Where(x => x.Id == id)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public Task UpdateAsync(FriendEntity friend, CancellationToken cancellationToken = default){
		return dbContext.Client.Updateable<FriendDataModel>()
			.SetColumns(x => new FriendDataModel {
				Name = friend.Name,
				Avatar = friend.Avatar,
				Category = friend.Category,
				Url = friend.Url.Value,
				Description = friend.Description,
				Email = friend.Email.Value,
				Status = friend.Status,
				IsTop = friend.IsTop,
				Sort = friend.Sort,
				IsDeleted = ToDbFlag(friend.IsDeleted),
				UpdatedAt = friend.UpdatedAt
			})
			.Where(x => x.Id == friend.Id)
			.ExecuteCommandAsync(cancellationToken);
	}

	public async Task<int> GetMaxSortAsync(CancellationToken cancellationToken = default){
		var maxSort = await dbContext.Client.Queryable<FriendDataModel>()
			.OrderByDescending(x => x.Sort)
			.FirstAsync(cancellationToken);

		return maxSort?.Sort ?? 0;
	}

	public async Task<int?> GetMinSortAsync(CancellationToken cancellationToken = default){
		var minSort = await dbContext.Client.Queryable<FriendDataModel>()
			.OrderBy(x => x.Sort)
			.FirstAsync(cancellationToken);

		return minSort?.Sort;
	}

	public async Task DeleteAsync(long id, CancellationToken cancellationToken = default){
		await dbContext.Client.Deleteable<FriendDataModel>()
			.Where(x => x.Id == id)
			.ExecuteCommandAsync(cancellationToken);
	}

	public async Task<PagedResult<AdminFriendPageItemDto>> GetAsync(GetAdminFriendPageListQuery query,
		CancellationToken cancellationToken = default){
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (pageNumber - 1) * pageSize;

		var friendQuery = dbContext.Client.Queryable<FriendDataModel>();

		if (!string.IsNullOrWhiteSpace(query.Name)) {
			var keyword = query.Name.Trim();
			friendQuery = friendQuery.Where(x => x.Name.Contains(keyword));
		}

		if (query.StartDate.HasValue) {
			var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			friendQuery = friendQuery.Where(x => x.CreatedAt >= start);
		}

		if (query.EndDate.HasValue) {
			var endExclusive = query.EndDate.Value.AddDays(1).ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			friendQuery = friendQuery.Where(x => x.CreatedAt < endExclusive);
		}

		var totalCount = await friendQuery.CountAsync(cancellationToken);
		var orderedFriendQuery = query.SortOrder?.ToLowerInvariant() switch {
			"timeasc" => friendQuery.OrderBy(x => x.CreatedAt),
			"timedesc" => friendQuery.OrderByDescending(x => x.CreatedAt),
			_ => friendQuery.OrderByDescending(x => x.IsTop).OrderByDescending(x => x.Sort).OrderByDescending(x => x.CreatedAt)
		};

		var friends = await orderedFriendQuery
			.Skip(skip)
			.Take(pageSize)
			.ToListAsync(cancellationToken);

		return new PagedResult<AdminFriendPageItemDto>(
			friends.Select(MapToAdminPageItem).ToArray(),
			pageNumber,
			pageSize,
			totalCount);
	}

	public async Task<FriendDetailDto?> GetAsync(GetFriendDetailQuery query,
		CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<FriendDataModel>()
			.Where(x => x.Id == query.FriendId && x.IsDeleted == 0)
			.SingleAsync();

		return data is null ? null : MapToDetailDto(data);
	}

	public async Task<PagedResult<FriendListItemDto>> GetAsync(GetFriendListQuery query,
		CancellationToken cancellationToken = default){
		var normalizedPageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var normalizedPageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (normalizedPageNumber - 1) * normalizedPageSize;

		var friendQuery = dbContext.Client.Queryable<FriendDataModel>()
			.Where(x => x.IsDeleted == 0);

		var totalCount = await friendQuery.CountAsync(cancellationToken);
		var friends = await friendQuery
			.OrderByDescending(x => x.IsTop)
			.OrderByDescending(x => x.Sort)
			.OrderByDescending(x => x.CreatedAt)
			.Skip(skip)
			.Take(normalizedPageSize)
			.ToListAsync(cancellationToken);

		return new PagedResult<FriendListItemDto>(
			friends.Select(MapToListItem).ToArray(),
			normalizedPageNumber,
			normalizedPageSize,
			totalCount);
	}

	private static FriendEntity MapToDomain(FriendDataModel data){
		return FriendEntity.Rehydrate(
			data.Id,
			data.Name,
			data.Description,
			data.Url,
			data.Avatar,
			data.Status,
			data.Category,
			data.IsTop,
			data.Email,
			data.Sort,
			FromDbFlag(data.IsDeleted),
			data.CreatedAt,
			data.UpdatedAt);
	}

	private static FriendListItemDto MapToListItem(FriendDataModel data){
		return new FriendListItemDto(
			data.Id,
			data.Name,
			data.Description,
			data.Url,
			data.Avatar,
			data.Status,
			data.CreatedAt,
			data.Category,
			data.IsTop,
			data.Email,
			data.Sort,
			data.UpdatedAt);
	}

	private static FriendDetailDto MapToDetailDto(FriendDataModel data){
		return new FriendDetailDto(
			data.Id,
			data.Name,
			data.Description,
			data.Url,
			data.Avatar,
			data.Status,
			data.CreatedAt,
			data.Category,
			data.IsTop,
			data.Email,
			data.Sort,
			data.UpdatedAt);
	}

	private static AdminFriendPageItemDto MapToAdminPageItem(FriendDataModel data){
		return new AdminFriendPageItemDto(
			data.Id,
			data.Name,
			data.Description,
			data.Url,
			data.Avatar,
			data.Status,
			data.CreatedAt,
			data.Category,
			data.IsTop,
			data.Email,
			data.Sort,
			FromDbFlag(data.IsDeleted),
			data.UpdatedAt);
	}

	private static bool FromDbFlag(short value) => value != 0;

	private static short ToDbFlag(bool value) => value ? (short)1 : (short)0;
}
