using UserEntity = Mint.Blog.Domain.System.User.Entities.User;
using Mint.Blog.Domain.System.User.ValueObjects;
namespace Mint.Blog.Domain.System.User.Repositories;

public interface IUserRepository {
	Task<UserEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default);
	Task<UserEntity?> GetByIdIncludingDeletedAsync(long id, CancellationToken cancellationToken = default);
	Task<UserEntity?> GetByUserNameAsync(UserName userName, CancellationToken cancellationToken = default);
	Task<bool> ExistsAsync(long id, CancellationToken cancellationToken = default);
	Task UpdateAsync(UserEntity user, CancellationToken cancellationToken = default);
	Task DeleteAsync(long id, CancellationToken cancellationToken = default);
	Task<IReadOnlyCollection<string>> GetRolesAsync(string userName, CancellationToken cancellationToken = default);
}
