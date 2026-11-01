using Mint.Blog.Model.Entitys.System;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Repository.Persistence;
using SqlSugar;
namespace Mint.Blog.Repository.Repositorys.System;
public sealed class AuthRepository(ISqlSugarDbContext db) : IAuthRepository {
    public Task<UserDataModel?> GetUserAsync(string username, CancellationToken cancellationToken = default) => db.Client.Queryable<UserDataModel>().Where(x => x.UserName == username && x.IsDeleted == 0 && x.Status == "active").SingleAsync()!;
    public Task<UserDataModel?> GetUserAsync(long id, CancellationToken cancellationToken = default) => db.Client.Queryable<UserDataModel>().Where(x => x.Id == id && x.IsDeleted == 0 && x.Status == "active").SingleAsync()!;
    public async Task<IReadOnlyCollection<string>> GetRolesAsync(string username, CancellationToken cancellationToken = default) => await db.Client.Ado.SqlQueryAsync<string>("SELECT r.code FROM sys_role r JOIN sys_user_role ur ON ur.role_id=r.id JOIN sys_user u ON u.id=ur.user_id WHERE u.username=@username AND u.is_deleted=0 AND u.status='active'", new { username });
    public Task UpdatePasswordAsync(UserDataModel user, CancellationToken cancellationToken = default) => db.Client.Updateable<UserDataModel>().SetColumns(x => new UserDataModel { UserName = user.UserName, DisplayName = user.DisplayName, Password = user.Password, IsDeleted = user.IsDeleted, UpdatedAt = user.UpdatedAt }).Where(x => x.Id == user.Id).ExecuteCommandAsync(cancellationToken);
    public Task<UserRefreshTokenDataModel?> GetTokenAsync(string hash, CancellationToken cancellationToken = default) => db.Client.Queryable<UserRefreshTokenDataModel>().Where(x => x.TokenHash == hash).SingleAsync()!;
    public Task AddTokenAsync(UserRefreshTokenDataModel token, CancellationToken cancellationToken = default) {
        token.Id = SnowFlakeSingle.Instance.NextId();
        return db.Client.Insertable(token).ExecuteCommandAsync(cancellationToken);
    }
    public async Task<bool> RevokeAsync(UserRefreshTokenDataModel token, CancellationToken cancellationToken = default) => await db.Client.Updateable<UserRefreshTokenDataModel>().SetColumns(x => new UserRefreshTokenDataModel { IsRevoked = token.IsRevoked, RevokedAt = token.RevokedAt }).Where(x => x.Id == token.Id && x.IsRevoked == 0).ExecuteCommandAsync(cancellationToken) == 1;
    public Task RevokeAllAsync(long userId, CancellationToken cancellationToken = default) => db.Client.Updateable<UserRefreshTokenDataModel>().SetColumns(x => new UserRefreshTokenDataModel { IsRevoked = 1, RevokedAt = DateTimeOffset.UtcNow }).Where(x => x.UserId == userId && x.IsRevoked == 0).ExecuteCommandAsync(cancellationToken);
    public Task<int> DeleteInvalidTokensCreatedBeforeAsync(DateTimeOffset boundary, CancellationToken cancellationToken = default) => db.Client.Deleteable<UserRefreshTokenDataModel>().Where(x => (x.IsRevoked == 1 || x.ExpiresAt < DateTimeOffset.UtcNow) && x.CreatedAt < boundary).ExecuteCommandAsync(cancellationToken);
}
