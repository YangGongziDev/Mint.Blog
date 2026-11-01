using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Comment;

namespace Mint.Blog.Service.IService.Blog;

public interface ICommentService {
    Task<PublishCommentResult> PublishAsync(PublishCommentCommand command, CancellationToken cancellationToken = default);
    Task DeleteAsync(DeleteCommentCommand command, CancellationToken cancellationToken = default);
    Task ExamineAsync(ExamineCommentCommand command, CancellationToken cancellationToken = default);
    Task<CommentListDto> GetAsync(GetCommentListQuery query, CancellationToken cancellationToken = default);
    Task<PagedResult<AdminCommentPageItemDto>> GetAsync(GetAdminCommentPageListQuery query, CancellationToken cancellationToken = default);
}
public interface ICommentNotificationQueue {
    ValueTask EnqueueAsync(CommentNotificationJob job, CancellationToken cancellationToken = default);
    IAsyncEnumerable<CommentNotificationJob> DequeueAllAsync(CancellationToken cancellationToken);
}
public interface ISensitiveWordService {
    IReadOnlyCollection<string> FindMatchedWords(string content);
}
public interface IQqUserInfoService {
    Task<QqUserInfoDto?> GetAsync(GetQqUserInfoQuery query, CancellationToken cancellationToken = default);
}
public interface ICommentNotificationService {
    Task NotifyCommentPublishedAsync(long commentId, CancellationToken cancellationToken = default);
    Task NotifyCommentExaminedAsync(long commentId, CancellationToken cancellationToken = default);
}
