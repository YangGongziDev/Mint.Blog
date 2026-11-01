using Mint.Blog.Model.Dtos.Blog.Message;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Message;

namespace Mint.Blog.Service.IService.Blog;

public interface IMessageService {
	Task<long> PublishAsync(PublishMessageCommand command, CancellationToken cancellationToken = default);
	Task<PagedResult<MessageListItemVo>> GetAsync(GetMessageListRequest query, CancellationToken cancellationToken = default);
}
