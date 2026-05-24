namespace Mint.Blog.Application.Abstractions;

public interface IImageReferenceUpdateService {
	Task ReplaceAsync(string oldImageUrl, string newImageUrl, CancellationToken cancellationToken = default);
}
