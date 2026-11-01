using Mint.Blog.Model.Dtos.Blog.Message;
using Mint.Blog.Model.Entitys.Blog.Message;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Message;

namespace Mint.Blog.Repository.IRepository.Blog;

public interface IMessageRepository {
	Task<long> AddAsync(MessageDataModel message, CancellationToken cancellationToken = default);
	Task<PagedResult<MessageListItemVo>> GetAsync(GetMessageListRequest query, CancellationToken cancellationToken = default);
}
