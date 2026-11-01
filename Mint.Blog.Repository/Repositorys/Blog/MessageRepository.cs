using Mint.Blog.Model.Dtos.Blog.Message;
using Mint.Blog.Model.Entitys.Blog.Message;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Message;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class MessageRepository(ISqlSugarDbContext dbContext) : IMessageRepository {
	public async Task<long> AddAsync(MessageDataModel message, CancellationToken cancellationToken = default) =>
		await dbContext.Client.Insertable(message).ExecuteReturnSnowflakeIdAsync();

	public async Task<PagedResult<MessageListItemVo>> GetAsync(GetMessageListRequest query, CancellationToken cancellationToken = default){
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (pageNumber - 1) * pageSize;
		var messageQuery = dbContext.Client.Queryable<MessageDataModel>().Where(x => x.IsPublished);
		var totalCount = await messageQuery.CountAsync();
		var messages = await messageQuery.OrderByDescending(x => x.CreatedAt).Skip(skip).Take(pageSize).ToListAsync();
		return new PagedResult<MessageListItemVo>(messages.Select(data => new MessageListItemVo(
			data.Id, data.Nickname, data.Website, data.Content, data.Color, data.CreatedAt)).ToArray(), pageNumber, pageSize, totalCount);
	}
}
