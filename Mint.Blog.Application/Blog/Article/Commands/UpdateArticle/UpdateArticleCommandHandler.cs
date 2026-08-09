using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Article;
using Mint.Blog.Domain.Blog.Article.Repositories;
using Mint.Blog.Domain.Blog.Category.Repositories;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Article.Commands.UpdateArticle;

public sealed class UpdateArticleCommandHandler(
	IArticleRepository articleRepository,
	ICategoryRepository categoryRepository,
	ITagRepository tagRepository,
	IUnitOfWork unitOfWork) {
	private const int SummaryMaxLength = 160;

	public async Task HandleAsync(UpdateArticleCommand command, CancellationToken cancellationToken = default){
		var title = Normalize(command.Title);
		var summary = Normalize(command.Summary);
		var content = Normalize(command.Content);
		var cover = Normalize(command.Cover);

		Guard.Against(string.IsNullOrWhiteSpace(title), ErrorCodes.ArticleTitleInvalid,
			"Article title is required.");
		Guard.Against(string.IsNullOrWhiteSpace(summary), ErrorCodes.ArticleSummaryInvalid,
			"Article summary is required.");
		Guard.Against(summary.Length > SummaryMaxLength, ErrorCodes.ArticleSummaryInvalid,
			$"Article summary cannot exceed {SummaryMaxLength} characters.");
		Guard.Against(string.IsNullOrWhiteSpace(content), ErrorCodes.ArticleContentInvalid,
			"Article content is required.");
		Guard.Against(string.IsNullOrWhiteSpace(cover), ErrorCodes.ArticleCoverInvalid,
			"Article cover is required.");

		Guard.Against(!Enum.IsDefined((ArticleVisibility)command.Visibility), ErrorCodes.ArticleContentInvalid,
			"Article visibility must be 1 or 2.");

		var article = await articleRepository.GetByIdAsync(command.ArticleId, cancellationToken);
		Guard.Against(article is null, ErrorCodes.ArticleNotFound, "Article does not exist.");

		var categoryExists = await categoryRepository.ExistsAsync(command.CategoryId, cancellationToken);
		Guard.Against(!categoryExists, ErrorCodes.CategoryNotFound, "Category does not exist.");

		var existingTagIds = await tagRepository.FilterExistingIdsAsync(command.TagIds, cancellationToken);
		Guard.Against(existingTagIds.Count != command.TagIds.Distinct().Count(), ErrorCodes.TagNotFound,
			"One or more tags do not exist.");

		article!.Update(
			title,
			summary,
			content,
			cover,
			command.CategoryId,
			existingTagIds,
			(ArticleVisibility)command.Visibility);

		await unitOfWork.BeginTransactionAsync(cancellationToken);

		try {
			await articleRepository.UpdateAsync(article, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}

	private static string Normalize(string? value) => value?.Trim() ?? string.Empty;
}