namespace Mint.Blog.Application.Blog.Article.Drafts;

public sealed record SaveArticleDraftCommand(
	string? DraftId,
	string? ArticleId,
	string? Title,
	string? Summary,
	string? Content,
	string? Cover,
	long? CategoryId,
	IReadOnlyCollection<long>? TagIds);
