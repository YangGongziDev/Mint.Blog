using System.Security.Cryptography;
using System.Text;

namespace Mint.Blog.Application.System.Auth;

public static class RefreshTokenCodec {
	public static string Encode(string token){
		return Convert.ToBase64String(Encoding.UTF8.GetBytes(token));
	}

	public static string Decode(string encodedToken){
		return Encoding.UTF8.GetString(Convert.FromBase64String(encodedToken.Trim()));
	}

	public static string ComputeHash(string token){
		var hash = SHA256.HashData(Encoding.UTF8.GetBytes(token));
		return Convert.ToHexString(hash);
	}
}
