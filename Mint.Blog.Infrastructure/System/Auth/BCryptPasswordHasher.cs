using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.System.User.ValueObjects;

namespace Mint.Blog.Infrastructure.System.Auth;

public sealed class BCryptPasswordHasher : IPasswordHasher {
	private const int WorkFactor = 12;

	public PasswordHash Hash(string password){
		if (string.IsNullOrWhiteSpace(password))
			throw new ArgumentException("Password is required.", nameof(password));

		var hash = BCrypt.Net.BCrypt.HashPassword(password.Trim(), WorkFactor);
		return PasswordHash.Create(hash);
	}

	public bool Verify(string password, PasswordHash passwordHash){
		if (string.IsNullOrWhiteSpace(password))
			return false;

		return BCrypt.Net.BCrypt.Verify(password.Trim(), passwordHash.Value);
	}
}
