using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Article.Repositories;
using Mint.Blog.Domain.Blog.Category.Repositories;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Article.Commands.UpdateArticle;

public sealed class UpdateArticleCommandHandler(
	IArticleRepository articleRepository,
	ICategoryRepository categoryRepository,
	ITagRepository tagRepository,
	IUnitOfWork unitOfWork) {
	public async Task HandleAsync(UpdateArticleCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Title), ErrorCodes.ArticleTitleInvalid,
			"Article title is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Summary), ErrorCodes.ArticleSummaryInvalid,
			"Article summary is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Content), ErrorCodes.ArticleContentInvalid,
			"Article content is required.");

		var article = await articleRepository.GetByIdAsync(command.ArticleId, cancellationToken);
		Guard.Against(article is null, ErrorCodes.ArticleNotFound, "Article does not exist.");

		var categoryExists = await categoryRepository.ExistsAsync(command.CategoryId, cancellationToken);
		Guard.Against(!categoryExists, ErrorCodes.CategoryNotFound, "Category does not exist.");

		var existingTagIds = await tagRepository.FilterExistingIdsAsync(command.TagIds, cancellationToken);
		Guard.Against(existingTagIds.Count != command.TagIds.Distinct().Count(), ErrorCodes.TagNotFound,
			"One or more tags do not exist.");

		article!.Update(
			command.Title.Trim(),
			command.Summary.Trim(),
			command.Content.Trim(),
			command.Cover.Trim(),
			command.CategoryId,
			existingTagIds);

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