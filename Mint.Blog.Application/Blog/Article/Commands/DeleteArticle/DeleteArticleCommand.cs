namespace Mint.Blog.Application.Blog.Article.Commands.DeleteArticle;

public sealed record DeleteArticleCommand(long ArticleId, long DeleteType);
