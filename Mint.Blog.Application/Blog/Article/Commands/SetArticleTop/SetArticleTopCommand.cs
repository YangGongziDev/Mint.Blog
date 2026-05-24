using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Article.Repositories;

namespace Mint.Blog.Application.Blog.Article.Commands.SetArticleTop;

public sealed record SetArticleTopCommand(long ArticleId, bool IsTop);

public sealed class SetArticleTopCommandHandler(
	IArticleRepository articleRepository,
	IUnitOfWork unitOfWork) {
	public async Task HandleAsync(SetArticleTopCommand command, CancellationToken cancellationToken = default){
		var article = await articleRepository.GetByIdAsync(command.ArticleId, cancellationToken);
		Guard.Against(article is null, ErrorCodes.ArticleNotFound, "Article does not exist.");

		article!.SetTop(command.IsTop);

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