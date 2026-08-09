using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Article;
using Mint.Blog.Domain.Blog.Article.Repositories;

namespace Mint.Blog.Application.Blog.Article.Commands.SetArticleVisibility;

public sealed record SetArticleVisibilityCommand(long ArticleId, short Visibility);

public sealed class SetArticleVisibilityCommandHandler(
	IArticleRepository articleRepository,
	IUnitOfWork unitOfWork) {
	public async Task HandleAsync(SetArticleVisibilityCommand command, CancellationToken cancellationToken = default){
		Guard.Against(!Enum.IsDefined((ArticleVisibility)command.Visibility), ErrorCodes.ArticleContentInvalid,
			"Article visibility must be 1 or 2.");

		var article = await articleRepository.GetByIdAsync(command.ArticleId, cancellationToken);
		Guard.Against(article is null, ErrorCodes.ArticleNotFound, "Article does not exist.");

		article!.SetVisibility((ArticleVisibility)command.Visibility);

		await unitOfWork.BeginTransactionAsync(cancellationToken);

		try {
			await articleRepository.UpdateAsync(article, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}
}
