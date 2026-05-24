namespace Mint.Blog.Application.Blog.Comment.Queries.GetAdminCommentPageList;

public sealed record AdminCommentPageItemDto(
	long Id,
	string RouterUrl,
	string Avatar,
	string Nickname,
	string Mail,
	string Website,
	DateTimeOffset CreatedAt,
	string Content,
	int Status,
	string Reason,
	bool IsDeleted);