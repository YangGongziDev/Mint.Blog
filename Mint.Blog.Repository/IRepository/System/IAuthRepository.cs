using Mint.Blog.Model.Entitys.System;
namespace Mint.Blog.Repository.IRepository.System;
public interface IAuthRepository {
    Task<UserDataModel?> GetUserAsync(string username, CancellationToken cancellationToken = default);
    Task<UserDataModel?> GetUserAsync(long id, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<string>> GetRolesAsync(string username, CancellationToken cancellationToken = default);
    Task UpdatePasswordAsync(UserDataModel user, CancellationToken cancellationToken = default);
    Task<UserRefreshTokenDataModel?> GetTokenAsync(string hash, CancellationToken cancellationToken = default);
    Task AddTokenAsync(UserRefreshTokenDataModel token, CancellationToken cancellationToken = default);
    Task<bool> RevokeAsync(UserRefreshTokenDataModel token, CancellationToken cancellationToken = default);
    Task RevokeAllAsync(long userId, CancellationToken cancellationToken = default);
    Task<int> DeleteInvalidTokensCreatedBeforeAsync(DateTimeOffset boundary, CancellationToken cancellationToken = default);
}
