namespace Mint.Blog.Application.Abstractions;

public sealed record AdminCredentialValidationResult(long UserId, string UserName, string DisplayName, IReadOnlyCollection<string> Roles);
