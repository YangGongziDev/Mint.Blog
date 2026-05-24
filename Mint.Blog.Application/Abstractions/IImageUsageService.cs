namespace Mint.Blog.Application.Abstractions;

public interface IImageUsageService {
	Task<bool> IsUsedAsync(string imageUrl, CancellationToken cancellationToken = default);
}
