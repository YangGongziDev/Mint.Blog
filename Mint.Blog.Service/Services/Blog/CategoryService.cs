using Mint.Blog.Common.Exceptions;
using Mint.Blog.Common.Constants;
using Mint.Blog.Model.Dtos.Blog.Category;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Category;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class CategoryService(ICategoryRepository categoryRepository, IResourceRepository resourceRepository,
    IUnitOfWork unitOfWork) : ICategoryService {
    public Task<IReadOnlyCollection<CategoryListItemDto>> GetAsync(CancellationToken cancellationToken = default) => categoryRepository.GetAsync(cancellationToken);
    public Task<PagedResult<CategoryListItemDto>> GetAsync(CategoryPageListQuery query, CancellationToken cancellationToken = default) => categoryRepository.GetAsync(query, cancellationToken);
    public async Task<long> CreateAsync(CreateCategoryCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.CategoryNameInvalid, "Category name is required.");
        return await categoryRepository.AddAsync(command.Name.Trim(), cancellationToken);
    }
    public async Task UpdateAsync(UpdateCategoryCommand command, CancellationToken cancellationToken = default) {
        await RequireCategoryAsync(command.CategoryId, cancellationToken);
        Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.CategoryNameInvalid, "Category name is required.");
        await categoryRepository.UpdateAsync(command.CategoryId, command.Name.Trim(), cancellationToken);
    }
    public async Task UpdateSortAsync(UpdateCategorySortCommand command, CancellationToken cancellationToken = default) {
        await RequireCategoryAsync(command.CategoryId, cancellationToken);
        await categoryRepository.UpdateSortAsync(command.CategoryId, command.Sort, cancellationToken);
    }
    public async Task MoveSortFirstAsync(MoveCategorySortFirstCommand command, CancellationToken cancellationToken = default) {
        await RequireCategoryAsync(command.CategoryId, cancellationToken);
        await categoryRepository.MoveSortFirstAsync(command.CategoryId, cancellationToken);
    }
    public async Task MoveSortLastAsync(MoveCategorySortLastCommand command, CancellationToken cancellationToken = default) {
        await RequireCategoryAsync(command.CategoryId, cancellationToken);
        await categoryRepository.MoveSortLastAsync(command.CategoryId, cancellationToken);
    }
    private async Task RequireCategoryAsync(long id, CancellationToken ct) =>
        Guard.Against(!await categoryRepository.ExistsAsync(id, ct), ErrorCodes.CategoryNotFound, "Category does not exist.");
    public async Task DeleteAsync(DeleteCategoryCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.DeleteType is not 1 and not 2 and not 3, ErrorCodes.DeleteTypeInvalid, "Delete type is invalid.");
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            Guard.Against(!await resourceRepository.LockCategoryAsync(command.CategoryId, cancellationToken, true), ErrorCodes.CategoryNotFound, "Category does not exist.");
            if (command.DeleteType is 1 or 2 && await resourceRepository.CategoryHasTagsAsync(command.CategoryId, command.DeleteType == 2, cancellationToken))
                throw new BusinessException("category_in_use", "分类仍被标签引用，不能删除；物理删除也检查已删除标签。");
            await categoryRepository.DeleteAsync(command.CategoryId, command.DeleteType, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
}
