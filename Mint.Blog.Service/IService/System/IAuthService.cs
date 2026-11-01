using Mint.Blog.Model.Dtos.System;
using Mint.Blog.Model.Vos.System;
namespace Mint.Blog.Service.IService.System;
public interface IAuthService {
    Task<LoginResult> LoginAsync(LoginCommand command, CancellationToken cancellationToken = default);
    Task<LoginResult> RefreshAsync(RefreshTokenCommand command, CancellationToken cancellationToken = default);
    Task LogoutAsync(LogoutCommand command, CancellationToken cancellationToken = default);
    Task ChangePasswordAsync(string username, ChangeOwnPasswordCommand command, CancellationToken cancellationToken = default);
    Task<int> CleanupAsync(DateTimeOffset boundary, CancellationToken cancellationToken = default);
}
