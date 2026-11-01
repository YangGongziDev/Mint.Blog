using Mint.Blog.Common.Storage;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class ArticleImageStorageAdapter(IObjectStorageService storage) : IArticleImageStorage {
	public Task DeleteManyAsync(IReadOnlyCollection<string> images, CancellationToken cancellationToken = default) =>
		storage.DeleteManyAsync(images, cancellationToken);
}
