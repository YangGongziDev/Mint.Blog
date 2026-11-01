using Mint.Blog.Model.Vos.System;
namespace Mint.Blog.Service.IService.System;
public interface IAdminIdentityQuery {
    Task<AdminUser?> GetAsync(string username, CancellationToken cancellationToken = default);
}
