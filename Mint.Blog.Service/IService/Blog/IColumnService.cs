using Mint.Blog.Model.Dtos.Blog.Column;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Column;

namespace Mint.Blog.Service.IService.Blog;

public interface IColumnService {
    Task<PagedResult<AdminColumnPageItemDto>> GetAsync(GetAdminColumnPageListQuery query, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<AdminColumnCatalogItemDto>> GetAsync(long columnId, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<BlogColumnListItemDto>> GetAsync(CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<BlogColumnCatalogItemDto>> GetAsync(BlogColumnCatalogQuery query, CancellationToken cancellationToken = default);
    Task<BlogColumnArticlePreNextDto> GetAsync(BlogColumnArticlePreNextQuery query, CancellationToken cancellationToken = default);
    Task<long> CreateAsync(CreateColumnCommand command, CancellationToken cancellationToken = default);
    Task UpdateAsync(UpdateColumnCommand command, CancellationToken cancellationToken = default);
    Task DeleteAsync(DeleteColumnCommand command, CancellationToken cancellationToken = default);
    Task SetPublishAsync(SetColumnPublishCommand command, CancellationToken cancellationToken = default);
    Task SetTopAsync(SetColumnTopCommand command, CancellationToken cancellationToken = default);
    Task UpdateSortAsync(UpdateColumnSortCommand command, CancellationToken cancellationToken = default);
    Task UpdateCatalogAsync(UpdateColumnCatalogCommand command, CancellationToken cancellationToken = default);
}
