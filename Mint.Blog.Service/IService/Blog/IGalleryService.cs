using Mint.Blog.Model.Dtos.Blog.Gallery;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Gallery;

namespace Mint.Blog.Service.IService.Blog;

public interface IGalleryService {
	Task<PagedResult<GalleryCategoryVo>> GetCategoriesAsync(GalleryCategoryPageQuery query, CancellationToken cancellationToken = default);
	Task<IReadOnlyCollection<GalleryCategoryVo>> GetCategoryOptionsAsync(CancellationToken cancellationToken = default);
	Task<PagedResult<GalleryImageVo>> GetImagesAsync(GalleryImagePageQuery query, CancellationToken cancellationToken = default);
	Task<long> CreateCategoryAsync(SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default);
	Task UpdateCategoryAsync(long id, SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default);
	Task DeleteCategoryAsync(long id, CancellationToken cancellationToken = default);
	Task<long> CreateImageAsync(SaveGalleryImageCommand command, CancellationToken cancellationToken = default);
	Task UpdateImageAsync(long id, SaveGalleryImageCommand command, CancellationToken cancellationToken = default);
	Task DeleteImageAsync(long id, CancellationToken cancellationToken = default);
}
