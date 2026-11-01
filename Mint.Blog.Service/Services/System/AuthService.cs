using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Common.Security;
using Mint.Blog.Model.Dtos.System;
using Mint.Blog.Model.Entitys.System;
using Mint.Blog.Model.Vos.System;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Service.IService.System;
namespace Mint.Blog.Service.Services.System;
public sealed class AuthService(IAuthRepository repository, ITokenService tokens, IPasswordHasher passwords, IUnitOfWork unitOfWork) : IAuthService {
    private static readonly TimeSpan AccessLifetime = TimeSpan.FromHours(2);
    private static readonly TimeSpan RefreshLifetime = TimeSpan.FromDays(7);
    private static readonly TimeSpan Retention = TimeSpan.FromDays(30);
    private const string Expired = "刷新登录已失效，请重新登录。";
    private static string NormalizeUserName(string value) {
        if (string.IsNullOrWhiteSpace(value)) throw new ArgumentException("User name is required.", nameof(value));
        var normalized = value.Trim();
        if (normalized.Length > 50) throw new ArgumentException("User name length must be less than or equal to 50.", nameof(value));
        return normalized;
    }
    private static UserDataModel? NormalizeUser(UserDataModel? user) {
        if (user is null) return null;
        user.UserName = NormalizeUserName(user.UserName);
        if (string.IsNullOrWhiteSpace(user.Password)) throw new ArgumentException("Password hash is required.", "value");
        user.Password = user.Password.Trim();
        return user;
    }
    private static UserRefreshTokenDataModel NewToken(long userId, string raw, DateTimeOffset expires) => new() { UserId = userId, TokenHash = RefreshTokenCodec.ComputeHash(raw), ExpiresAt = expires, CreatedAt = DateTimeOffset.UtcNow };
    public async Task<LoginResult> LoginAsync(LoginCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.UserName), ErrorCodes.LoginInvalid, "User name is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.Password), ErrorCodes.LoginInvalid, "Password is required.");
        var name = NormalizeUserName(command.UserName);
        var user = NormalizeUser(await repository.GetUserAsync(name, cancellationToken));
        Guard.Against(user is null || !passwords.Verify(command.Password, user.Password.Trim()), ErrorCodes.LoginInvalid, "Invalid user name or password.");
        var roles = await repository.GetRolesAsync(name, cancellationToken);
        var now = DateTimeOffset.UtcNow;
        var expires = now.Add(AccessLifetime);
        var refreshExpires = now.Add(RefreshLifetime);
        var access = tokens.GenerateAccessToken(user!.Id, NormalizeUserName(user.UserName), roles);
        var raw = tokens.GenerateRefreshToken();
        var token = NewToken(user.Id, raw, refreshExpires);
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            await repository.DeleteInvalidTokensCreatedBeforeAsync(now.Subtract(Retention), cancellationToken);
            await repository.RevokeAllAsync(user.Id, cancellationToken);
            await repository.AddTokenAsync(token, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch { await unitOfWork.RollbackAsync(cancellationToken); throw; }
        return new LoginResult(access, RefreshTokenCodec.Encode(raw), expires, refreshExpires, NormalizeUserName(user.UserName), user.DisplayName);
    }
    public async Task<LoginResult> RefreshAsync(RefreshTokenCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.RefreshToken), ErrorCodes.RefreshTokenInvalid, "Refresh token is required.");
        string raw;
        try { raw = RefreshTokenCodec.Decode(command.RefreshToken); }
        catch { throw new BusinessException(ErrorCodes.RefreshTokenInvalid, Expired); }
        var current = await repository.GetTokenAsync(RefreshTokenCodec.ComputeHash(raw), cancellationToken);
        if (current is null || current.IsRevoked != 0 || current.ExpiresAt <= DateTimeOffset.UtcNow) throw new BusinessException(ErrorCodes.RefreshTokenInvalid, Expired);
        var user = NormalizeUser(await repository.GetUserAsync(current.UserId, cancellationToken));
        if (user is null) throw new BusinessException(ErrorCodes.RefreshTokenInvalid, Expired);
        var name = NormalizeUserName(user.UserName);
        var now = DateTimeOffset.UtcNow;
        var expires = now.Add(AccessLifetime);
        var refreshExpires = now.Add(RefreshLifetime);
        var roles = await repository.GetRolesAsync(name, cancellationToken);
        var access = tokens.GenerateAccessToken(user.Id, name, roles);
        var nextRaw = tokens.GenerateRefreshToken();
        var next = NewToken(user.Id, nextRaw, refreshExpires);
        current.IsRevoked = 1; current.RevokedAt = now;
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            await repository.DeleteInvalidTokensCreatedBeforeAsync(now.Subtract(Retention), cancellationToken);
            await RevokeAsync(current, cancellationToken);
            await repository.AddTokenAsync(next, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch { await unitOfWork.RollbackAsync(cancellationToken); throw; }
        return new LoginResult(access, RefreshTokenCodec.Encode(nextRaw), expires, refreshExpires, name, user.DisplayName);
    }
    private async Task RevokeAsync(UserRefreshTokenDataModel token, CancellationToken cancellationToken) {
        if (!await repository.RevokeAsync(token, cancellationToken)) throw new BusinessException(ErrorCodes.RefreshTokenInvalid, "刷新令牌已被使用或吊销");
    }
    public async Task LogoutAsync(LogoutCommand command, CancellationToken cancellationToken = default) {
        if (string.IsNullOrWhiteSpace(command.RefreshToken)) return;
        string raw;
        try { raw = RefreshTokenCodec.Decode(command.RefreshToken); } catch { return; }
        var token = await repository.GetTokenAsync(RefreshTokenCodec.ComputeHash(raw), cancellationToken);
        if (token is null || token.IsRevoked != 0) return;
        token.IsRevoked = 1; token.RevokedAt = DateTimeOffset.UtcNow;
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try { await RevokeAsync(token, cancellationToken); await unitOfWork.CommitAsync(cancellationToken); }
        catch { await unitOfWork.RollbackAsync(cancellationToken); throw; }
    }
    public async Task ChangePasswordAsync(string username, ChangeOwnPasswordCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrEmpty(command.NewPassword) || command.NewPassword.Length < 6 || command.NewPassword.Length > 64, ErrorCodes.UserPasswordInvalid, "新密码长度须为 6 至 64 个字符");
        var user = NormalizeUser(await repository.GetUserAsync(NormalizeUserName(username), cancellationToken));
        Guard.Against(user is null, ErrorCodes.Unauthorized, "账号不存在或已禁用");
        Guard.Against(string.IsNullOrEmpty(command.OldPassword) || !passwords.Verify(command.OldPassword, user!.Password.Trim()), ErrorCodes.UserPasswordInvalid, "原密码错误");
        var hash = passwords.Hash(command.NewPassword);
        if (user!.Password.Trim() != hash) { user.Password = hash; user.UpdatedAt = DateTimeOffset.UtcNow; }
        user.UserName = NormalizeUserName(user.UserName);
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            await repository.UpdatePasswordAsync(user, cancellationToken);
            await repository.RevokeAllAsync(user.Id, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch { await unitOfWork.RollbackAsync(cancellationToken); throw; }
    }
    public Task<int> CleanupAsync(DateTimeOffset boundary, CancellationToken cancellationToken = default) => repository.DeleteInvalidTokensCreatedBeforeAsync(boundary, cancellationToken);
}
