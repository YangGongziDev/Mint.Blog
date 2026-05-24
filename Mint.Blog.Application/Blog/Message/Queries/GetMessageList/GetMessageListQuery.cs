namespace Mint.Blog.Application.Blog.Message.Queries.GetMessageList;

public sealed record GetMessageListQuery(
	int PageNumber = 1,
	int PageSize = 10);
