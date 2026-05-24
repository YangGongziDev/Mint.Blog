using System.Security.Cryptography;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.System.Auth;

public sealed class JwtTokenService(IOptions<JwtOptions> options) : ITokenService {
	public string GenerateAccessToken(long userId, string userName, IReadOnlyCollection<string> roles){
		var jwtOptions = options.Value;
		var now = DateTime.UtcNow;
		var expiresAt = now.AddMinutes(jwtOptions.AccessTokenExpireMinutes);
		var credentials = new SigningCredentials(
			new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtOptions.SecurityKey)),
			SecurityAlgorithms.HmacSha256);

		var claims = new List<Claim> {
			new(JwtRegisteredClaimNames.Sub, userId.ToString()),
			new(JwtRegisteredClaimNames.UniqueName, userName),
			new(ClaimTypes.NameIdentifier, userId.ToString()),
			new(ClaimTypes.Name, userName)
		};

		claims.AddRange(roles.Select(role => new Claim(ClaimTypes.Role, role)));

		var token = new JwtSecurityToken(
			jwtOptions.Issuer,
			jwtOptions.Audience,
			claims,
			now,
			expiresAt,
			credentials);

		return new JwtSecurityTokenHandler().WriteToken(token);
	}

	public string GenerateRefreshToken(){
		return Convert.ToHexString(RandomNumberGenerator.GetBytes(32));
	}
}
