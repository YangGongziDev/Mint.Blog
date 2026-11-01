using Mint.Blog.Model.Dtos.Blog.Category;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Category;

namespace Mint.Blog.Service.IService.Blog;

public interface ICategoryService {
    Task<IReadOnlyCollection<CategoryListItemDto>> GetAsync(CancellationToken cancellationToken = default);
    Task<PagedResult<CategoryListItemDto>> GetAsync(CategoryPageListQuery query, CancellationToken cancellationToken = default);
    Task<long> CreateAsync(CreateCategoryCommand command, CancellationToken cancellationToken = default);
    Task UpdateAsync(UpdateCategoryCommand command, CancellationToken cancellationToken = default);
    Task UpdateSortAsync(UpdateCategorySortCommand command, CancellationToken cancellationToken = default);
    Task MoveSortFirstAsync(MoveCategorySortFirstCommand command, CancellationToken cancellationToken = default);
    Task MoveSortLastAsync(MoveCategorySortLastCommand command, CancellationToken cancellationToken = default);
    Task DeleteAsync(DeleteCategoryCommand command, CancellationToken cancellationToken = default);
}
