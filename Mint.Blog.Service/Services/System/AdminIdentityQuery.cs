using Mint.Blog.Model.Vos.System;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Service.IService.System;
namespace Mint.Blog.Service.Services.System;
public sealed class AdminIdentityQuery(IAdminIdentityRepository repository) : IAdminIdentityQuery {
    public Task<AdminUser?> GetAsync(string username, CancellationToken cancellationToken = default) => repository.GetAsync(username, cancellationToken);
}
