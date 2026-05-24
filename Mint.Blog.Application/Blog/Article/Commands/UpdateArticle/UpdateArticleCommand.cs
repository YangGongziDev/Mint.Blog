namespace Mint.Blog.Application.Blog.Article.Commands.UpdateArticle;

public sealed record UpdateArticleCommand(
	long ArticleId,
	string Title,
	string Summary,
	string Content,
	string Cover,
	long CategoryId,
	IReadOnlyCollection<long> TagIds);