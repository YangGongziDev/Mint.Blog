using UserEntity = Mint.Blog.Domain.System.User.Entities.User;
using Mint.Blog.Domain.System.User.ValueObjects;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.System.User.Persistence.SqlSugar.Models;

namespace Mint.Blog.Infrastructure.System.User.Persistence.Repositories;

public sealed class UserRepository(ISqlSugarDbContext dbContext)
	: IUserRepository {
	public async Task<UserEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<UserDataModel>()
			.Where(x => x.Id == id && x.IsDeleted == 0 && x.Status == "active")
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task<UserEntity?> GetByUserNameAsync(UserName userName, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<UserDataModel>()
			.Where(x => x.UserName == userName.Value && x.IsDeleted == 0 && x.Status == "active")
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
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
		return await dbContext.Client.Ado.SqlQueryAsync<string>(
			"SELECT r.code FROM sys_role r JOIN sys_user_role ur ON ur.role_id=r.id JOIN sys_user u ON u.id=ur.user_id WHERE u.username=@userName AND u.is_deleted=0 AND u.status='active'",
			new { userName });
	}

	private static UserEntity MapToDomain(UserDataModel data){
		return UserEntity.Rehydrate(data.Id, data.UserName, data.DisplayName, data.Password, data.IsDeleted != 0,
			data.CreatedAt, data.UpdatedAt);
	}
}
