using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Message.Queries.GetMessageList;
using Mint.Blog.Domain.Blog.Message.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Message.Persistence;
using MessageEntity = Mint.Blog.Domain.Blog.Message.Entities.Message;

namespace Mint.Blog.Infrastructure.Blog.Message.Repositories;

public sealed class MessageRepository(ISqlSugarDbContext dbContext)
	: IMessageRepository, IGetMessageListQueryService {
	public async Task<long> AddAsync(MessageEntity message, CancellationToken cancellationToken = default){
		var data = new MessageDataModel {
			Nickname = message.Nickname,
			Email = message.Email,
			Website = message.Website,
			Content = message.Content,
			Color = message.Color,
			IsPublished = message.IsPublished,
			CreatedAt = message.CreatedAt,
			UpdatedAt = message.UpdatedAt
		};

		return await dbContext.Client.Insertable(data).ExecuteReturnSnowflakeIdAsync();
	}

	public async Task<PagedResult<MessageListItemDto>> GetAsync(GetMessageListQuery query,
		CancellationToken cancellationToken = default){
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (pageNumber - 1) * pageSize;

		var messageQuery = dbContext.Client.Queryable<MessageDataModel>()
			.Where(x => x.IsPublished);

		var totalCount = await messageQuery.CountAsync();
		var messages = await messageQuery
			.OrderByDescending(x => x.CreatedAt)
			.Skip(skip)
			.Take(pageSize)
			.ToListAsync();

		return new PagedResult<MessageListItemDto>(
			messages.Select(MapToDto).ToArray(),
			pageNumber,
			pageSize,
			totalCount);
	}

	private static MessageListItemDto MapToDto(MessageDataModel data){
		return new MessageListItemDto(
			data.Id,
			data.Nickname,
			data.Website,
			data.Content,
			data.Color,
			data.CreatedAt);
	}
}
