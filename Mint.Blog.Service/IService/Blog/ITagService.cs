using Mint.Blog.Model.Dtos.Blog.Tag;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Tag;

namespace Mint.Blog.Service.IService.Blog;

public interface ITagService {
    Task<IReadOnlyCollection<TagListItemDto>> GetAsync(CancellationToken cancellationToken = default);
    Task<PagedResult<TagListItemDto>> GetAsync(TagPageListQuery query, CancellationToken cancellationToken = default);
    Task<long> CreateAsync(CreateTagCommand command, CancellationToken cancellationToken = default);
    Task UpdateAsync(UpdateTagCommand command, CancellationToken cancellationToken = default);
    Task UpdateSortAsync(UpdateTagSortCommand command, CancellationToken cancellationToken = default);
    Task MoveSortFirstAsync(MoveTagSortFirstCommand command, CancellationToken cancellationToken = default);
    Task MoveSortLastAsync(MoveTagSortLastCommand command, CancellationToken cancellationToken = default);
    Task DeleteAsync(DeleteTagCommand command, CancellationToken cancellationToken = default);
}
