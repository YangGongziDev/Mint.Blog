using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Model.Entitys.Blog.Comment;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface ICommentRepository {
    Task<long> AddAsync(CommentDataModel comment, CancellationToken cancellationToken = default);
    Task<CommentDataModel?> GetAsync(long id, bool includingDeleted = false, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<CommentDataModel>> GetAllAsync(CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<CommentDataModel>> GetNormalAsync(string routerUrl, CancellationToken cancellationToken = default);
    Task UpdateAsync(CommentDataModel comment, CancellationToken cancellationToken = default);
    Task<(IReadOnlyCollection<CommentDataModel> Items, int Total)> GetPageAsync(GetAdminCommentPageListQuery query, DateTime? start, DateTime? end, CancellationToken cancellationToken = default);
}
