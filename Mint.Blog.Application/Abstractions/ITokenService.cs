namespace Mint.Blog.Application.Abstractions;

public interface ITokenService {
	string GenerateAccessToken(long userId, string userName, IReadOnlyCollection<string> roles);
	string GenerateRefreshToken();
}
