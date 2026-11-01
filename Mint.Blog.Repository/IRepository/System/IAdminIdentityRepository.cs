using Mint.Blog.Model.Vos.System;
namespace Mint.Blog.Repository.IRepository.System;
public interface IAdminIdentityRepository {
    Task<AdminUser?> GetAsync(string username, CancellationToken cancellationToken = default);
}
