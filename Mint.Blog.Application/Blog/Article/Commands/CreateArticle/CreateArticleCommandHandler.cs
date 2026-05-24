using ArticleEntity = Mint.Blog.Domain.Blog.Article.Entities.Article;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Article.Repositories;
using Mint.Blog.Domain.Blog.Category.Repositories;
using Mint.Blog.Domain.Blog.Tag.Repositories;

namespace Mint.Blog.Application.Blog.Article.Commands.CreateArticle;

public sealed class CreateArticleCommandHandler(
	IArticleRepository articleRepository,
	ICategoryRepository categoryRepository,
	ITagRepository tagRepository,
	IUnitOfWork unitOfWork) {
	public async Task<long> HandleAsync(CreateArticleCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Title), ErrorCodes.ArticleTitleInvalid,
			"Article title is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Summary), ErrorCodes.ArticleSummaryInvalid,
			"Article summary is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Content), ErrorCodes.ArticleContentInvalid,
			"Article content is required.");

		var categoryExists = await categoryRepository.ExistsAsync(command.CategoryId, cancellationToken);
		Guard.Against(!categoryExists, ErrorCodes.CategoryNotFound, "Category does not exist.");

		var existingTagIds = await tagRepository.FilterExistingIdsAsync(command.TagIds, cancellationToken);
		Guard.Against(existingTagIds.Count != command.TagIds.Distinct().Count(), ErrorCodes.TagNotFound,
			"One or more tags do not exist.");

		var article = ArticleEntity.Create(
			command.Title.Trim(),
			command.Summary.Trim(),
			command.Content.Trim(),
			command.Cover.Trim(),
			command.CategoryId,
			existingTagIds);

		await unitOfWork.BeginTransactionAsync(cancellationToken);

		try {
			var articleId = await articleRepository.AddAsync(article, cancellationToken);
			await unitOfWork.CommitAsync(cancellationToken);
			return articleId;
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}
	}
}