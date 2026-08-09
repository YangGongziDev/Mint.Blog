namespace Mint.Blog.Application.Blog.Article.Commands.CreateArticle;

public sealed record CreateArticleCommand(
	string Title,
	string Summary,
	string Content,
	string Cover,
	long CategoryId,
	IReadOnlyCollection<long> TagIds,
	short Visibility);