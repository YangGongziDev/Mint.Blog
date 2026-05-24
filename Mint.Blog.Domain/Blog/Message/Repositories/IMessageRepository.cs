using MessageEntity = Mint.Blog.Domain.Blog.Message.Entities.Message;
namespace Mint.Blog.Domain.Blog.Message.Repositories;

public interface IMessageRepository {
	Task<long> AddAsync(MessageEntity message, CancellationToken cancellationToken = default);
}
