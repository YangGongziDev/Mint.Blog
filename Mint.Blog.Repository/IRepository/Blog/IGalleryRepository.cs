using Mint.Blog.Model.Dtos.Blog.Gallery;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Gallery;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IGalleryRepository {
	void EnsureTables();
	Task<PagedResult<GalleryCategoryVo>> GetCategoriesAsync(GalleryCategoryPageQuery query, CancellationToken cancellationToken = default);
	Task<IReadOnlyCollection<GalleryCategoryVo>> GetCategoryOptionsAsync(CancellationToken cancellationToken = default);
	Task<PagedResult<GalleryImageVo>> GetImagesAsync(GalleryImagePageQuery query, CancellationToken cancellationToken = default);
	Task<long> CreateCategoryAsync(SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default);
	Task<int> UpdateCategoryAsync(long id, SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default);
	Task<bool> CategoryIsUsedAsync(long id, CancellationToken cancellationToken = default);
	Task<bool> CategoryExistsAsync(long id, CancellationToken cancellationToken = default);
	Task DeleteCategoryAsync(long id, CancellationToken cancellationToken = default);
	Task<long> CreateImageAsync(SaveGalleryImageCommand command, CancellationToken cancellationToken = default);
	Task<int> UpdateImageAsync(long id, SaveGalleryImageCommand command, CancellationToken cancellationToken = default);
	Task DeleteImageAsync(long id, CancellationToken cancellationToken = default);
}
