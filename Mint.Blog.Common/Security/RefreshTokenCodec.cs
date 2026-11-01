using System.Security.Cryptography;
using System.Text;
namespace Mint.Blog.Common.Security;
public static class RefreshTokenCodec {
    public static string Encode(string token) => Convert.ToBase64String(Encoding.UTF8.GetBytes(token));
    public static string Decode(string encodedToken) => Encoding.UTF8.GetString(Convert.FromBase64String(encodedToken.Trim()));
    public static string ComputeHash(string token) => Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(token)));
}
