namespace Mint.Blog.Application.Abstractions;

public interface IAdminCredentialValidator {
	AdminCredentialValidationResult? Validate(string userName, string password);
}