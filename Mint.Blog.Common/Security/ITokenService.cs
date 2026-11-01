namespace Mint.Blog.Common.Security;
public interface ITokenService {
    string GenerateAccessToken(long userId, string userName, IReadOnlyCollection<string> roles);
    string GenerateRefreshToken();
}
