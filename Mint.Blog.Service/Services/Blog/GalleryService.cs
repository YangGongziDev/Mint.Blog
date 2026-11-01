using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Gallery;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Gallery;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class GalleryService(IGalleryRepository repository) : IGalleryService {
	public Task<PagedResult<GalleryCategoryVo>> GetCategoriesAsync(GalleryCategoryPageQuery query, CancellationToken cancellationToken = default) => repository.GetCategoriesAsync(query, cancellationToken);
	public Task<IReadOnlyCollection<GalleryCategoryVo>> GetCategoryOptionsAsync(CancellationToken cancellationToken = default) => repository.GetCategoryOptionsAsync(cancellationToken);
	public Task<PagedResult<GalleryImageVo>> GetImagesAsync(GalleryImagePageQuery query, CancellationToken cancellationToken = default) => repository.GetImagesAsync(query, cancellationToken);

	public Task<long> CreateCategoryAsync(SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default){
		repository.EnsureTables();
		ValidateCategory(command);
		return repository.CreateCategoryAsync(command, cancellationToken);
	}

	public async Task UpdateCategoryAsync(long id, SaveGalleryCategoryCommand command, CancellationToken cancellationToken = default){
		repository.EnsureTables();
		ValidateCategory(command);
		var affected = await repository.UpdateCategoryAsync(id, command, cancellationToken);
		Guard.Against(affected <= 0, ErrorCodes.CategoryNotFound, "Gallery category not found.");
	}

	public async Task DeleteCategoryAsync(long id, CancellationToken cancellationToken = default){
		repository.EnsureTables();
		var used = await repository.CategoryIsUsedAsync(id, cancellationToken);
		Guard.Against(used, ErrorCodes.DeleteTypeInvalid, "Gallery category is used by images.");
		await repository.DeleteCategoryAsync(id, cancellationToken);
	}

	public async Task<long> CreateImageAsync(SaveGalleryImageCommand command, CancellationToken cancellationToken = default){
		repository.EnsureTables();
		await ValidateImageAsync(command, cancellationToken);
		return await repository.CreateImageAsync(command with { SourceType = NormalizeSourceType(command.SourceType) }, cancellationToken);
	}

	public async Task UpdateImageAsync(long id, SaveGalleryImageCommand command, CancellationToken cancellationToken = default){
		repository.EnsureTables();
		await ValidateImageAsync(command, cancellationToken);
		var affected = await repository.UpdateImageAsync(id, command with { SourceType = NormalizeSourceType(command.SourceType) }, cancellationToken);
		Guard.Against(affected <= 0, ErrorCodes.ArticleNotFound, "Gallery image not found.");
	}

	public Task DeleteImageAsync(long id, CancellationToken cancellationToken = default){
		repository.EnsureTables();
		return repository.DeleteImageAsync(id, cancellationToken);
	}

	private async Task ValidateImageAsync(SaveGalleryImageCommand command, CancellationToken cancellationToken){
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.ArticleTitleInvalid, "Gallery image name is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Url), ErrorCodes.ArticleCoverInvalid, "Gallery image url is required.");
		Guard.Against(command.Size < 0, ErrorCodes.ArticleCoverInvalid, "Gallery image size must be greater than or equal to 0.");
		var categoryExists = await repository.CategoryExistsAsync(command.CategoryId, cancellationToken);
		Guard.Against(!categoryExists, ErrorCodes.CategoryNotFound, "Gallery category not found.");
		_ = NormalizeSourceType(command.SourceType);
	}

	private static void ValidateCategory(SaveGalleryCategoryCommand command) =>
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.CategoryNameInvalid, "Gallery category name is required.");

	private static string NormalizeSourceType(string sourceType){
		var normalized = string.IsNullOrWhiteSpace(sourceType) ? "local" : sourceType.Trim().ToLowerInvariant();
		Guard.Against(normalized is not "local" and not "external", ErrorCodes.ArticleCoverInvalid, "Gallery image source type is invalid.");
		return normalized;
	}
}
