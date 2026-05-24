using Mint.Blog.Domain.System.User.ValueObjects;

namespace Mint.Blog.Application.Abstractions;

public interface IPasswordHasher {
	PasswordHash Hash(string password);
	bool Verify(string password, PasswordHash passwordHash);
}
