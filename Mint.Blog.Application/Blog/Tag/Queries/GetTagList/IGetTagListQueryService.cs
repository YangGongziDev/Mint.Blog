namespace Mint.Blog.Application.Blog.Tag.Queries.GetTagList;

public interface IGetTagListQueryService {
	Task<IReadOnlyCollection<TagListItemDto>> GetAsync(CancellationToken cancellationToken = default);
}