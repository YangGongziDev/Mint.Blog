namespace Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnArticlePreNext;

public sealed record BlogColumnArticlePreNextDto(
	BlogColumnArticleLinkDto? PreArticle,
	BlogColumnArticleLinkDto? NextArticle);