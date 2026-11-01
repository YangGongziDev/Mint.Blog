namespace Mint.Blog.Common.Security;
public sealed class BCryptPasswordHasher : IPasswordHasher {
    private const int WorkFactor = 12;
    public string Hash(string password) {
        if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Password is required.", nameof(password));
        return BCrypt.Net.BCrypt.HashPassword(password.Trim(), WorkFactor).Trim();
    }
    public bool Verify(string password, string passwordHash) {
        if (string.IsNullOrWhiteSpace(password)) return false;
        return BCrypt.Net.BCrypt.Verify(password.Trim(), passwordHash);
    }
}
