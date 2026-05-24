using UserEntity = Mint.Blog.Domain.System.User.Entities.User;
using Mint.Blog.Application.System.Dtos;
using Mint.Blog.Application.System.User.Queries.GetSystemUserInfo;
using Mint.Blog.Application.System.User.Queries.GetUserList;
using Mint.Blog.Domain.System.User.ValueObjects;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;

namespace Mint.Blog.Infrastructure.System.User.Persistence.Repositories;

public sealed class UserRepository(ISqlSugarDbContext dbContext)
	: IUserRepository, IGetSystemUserInfoQueryService, IGetUserListQueryService {
	public async Task<SystemUserInfoDto?> GetAsync(string userName, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<UserDataModel>()
			.Where(x => x.UserName == userName && x.IsDeleted == 0)
			.SingleAsync();

		if (data is null) return null;

		var roles = await dbContext.Client.Queryable<UserRoleDataModel>()
			.Where(x => x.UserName == userName)
			.Select(x => x.Role)
			.ToListAsync(cancellationToken);

		return new SystemUserInfoDto(data.Id.ToString(), data.UserName, data.DisplayName, roles, []);
	}

	public async Task<PaginatedListDto<UserDto>> GetAsync(GetUserListQuery query,
		CancellationToken cancellationToken = default){
		var current = query.Current <= 0 ? 1 : query.Current;
		var size = query.Size <= 0 ? 10 : query.Size;
		var skip = (current - 1) * size;

		var userQueryable = dbContext.Client.Queryable<UserDataModel>();

		if (!string.IsNullOrWhiteSpace(query.UserName))
			userQueryable = userQueryable.Where(x => x.UserName.Contains(query.UserName));

		if (!string.IsNullOrWhiteSpace(query.DisplayName))
			userQueryable = userQueryable.Where(x => x.DisplayName.Contains(query.DisplayName));

		if (query.IsDeleted.HasValue)
			userQueryable = userQueryable.Where(x => x.IsDeleted == query.IsDeleted.Value);

		var total = await userQueryable.CountAsync();
		var users = await userQueryable
			.OrderByDescending(x => x.CreatedAt)
			.Skip(skip)
			.Take(size)
			.ToListAsync();

		var records = users.Select(MapToDto).ToList();

		return new PaginatedListDto<UserDto> {
			Current = current,
			Size = size,
			Total = total,
			Records = records
		};
	}

	public async Task<UserEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<UserDataModel>()
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task<UserEntity?> GetByIdIncludingDeletedAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<UserDataModel>()
			.Where(x => x.Id == id)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task<UserEntity?> GetByUserNameAsync(UserName userName, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<UserDataModel>()
			.Where(x => x.UserName == userName.Value && x.IsDeleted == 0)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default){
		return dbContext.Client.Queryable<UserDataModel>()
			.AnyAsync(x => x.Id == id, cancellationToken);
	}

	public Task UpdateAsync(UserEntity user, CancellationToken cancellationToken = default){
		return dbContext.Client.Updateable<UserDataModel>()
			.SetColumns(x => new UserDataModel {
				UserName = user.UserName.Value,
				DisplayName = user.DisplayName,
				Password = user.PasswordHash.Value,
				IsDeleted = (short)(user.IsDeleted ? 1 : 0),
				UpdatedAt = user.UpdatedAt
			})
			.Where(x => x.Id == user.Id)
			.ExecuteCommandAsync(cancellationToken);
	}

	public async Task<IReadOnlyCollection<string>> GetRolesAsync(string userName, CancellationToken cancellationToken = default){
		var roles = await dbContext.Client.Queryable<UserRoleDataModel>()
			.Where(x => x.UserName == userName)
			.Select(x => x.Role)
			.ToListAsync(cancellationToken);

		return roles;
	}

	public async Task DeleteAsync(long id, CancellationToken cancellationToken = default){
		await dbContext.Client.Deleteable<UserDataModel>()
			.Where(x => x.Id == id)
			.ExecuteCommandAsync(cancellationToken);
	}

	private static UserDto MapToDto(UserDataModel data){
		return new UserDto {
			Id = data.Id,
			UserName = data.UserName,
			DisplayName = data.DisplayName,
			IsDeleted = data.IsDeleted,
			CreateBy = string.Empty,
			CreateTime = data.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss"),
			UpdateBy = string.Empty,
			UpdateTime = data.UpdatedAt.ToString("yyyy-MM-dd HH:mm:ss"),
			Status = data.IsDeleted == 0 ? "1" : "2"
		};
	}

	private static UserEntity MapToDomain(UserDataModel data){
		return UserEntity.Rehydrate(data.Id, data.UserName, data.DisplayName, data.Password, data.IsDeleted != 0,
			data.CreatedAt, data.UpdatedAt);
	}
}
