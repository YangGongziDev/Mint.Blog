using System.Text.RegularExpressions;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Article.Repositories;

namespace Mint.Blog.Application.Blog.Article.Commands.DeleteArticle;

public sealed partial class DeleteArticleCommandHandler(
	IArticleRepository articleRepository,
	IUnitOfWork unitOfWork,
	IObjectStorageService objectStorageService,
	IImageUsageService imageUsageService) {
	public async Task HandleAsync(DeleteArticleCommand command, CancellationToken cancellationToken = default){
		Guard.Against(command.DeleteType is not 1 and not 2, ErrorCodes.DeleteTypeInvalid,
			"Delete type is invalid.");

		var article = await articleRepository.GetByIdAsync(command.ArticleId, cancellationToken);
		Guard.Against(article is null, ErrorCodes.ArticleNotFound, "Article does not exist.");
		IReadOnlyCollection<string> articleImages = command.DeleteType == 2 ? GetArticleImages(article!) : [];

		await unitOfWork.BeginTransactionAsync(cancellationToken);

		try {
			if (command.DeleteType == 1) {
				article!.MarkDeleted();
				await articleRepository.UpdateAsync(article, cancellationToken);
			} else {
				await articleRepository.DeleteAsync(command.ArticleId, command.DeleteType, cancellationToken);
			}

			await unitOfWork.CommitAsync(cancellationToken);
		} catch {
			await unitOfWork.RollbackAsync(cancellationToken);
			throw;
		}

		if (command.DeleteType == 2) await CleanUnusedImagesAsync(articleImages, cancellationToken);
	}

	private async Task CleanUnusedImagesAsync(IReadOnlyCollection<string> images,
		CancellationToken cancellationToken = default){
		if (images.Count == 0) return;

		var removableImages = new List<string>();
		foreach (var image in images) {
			if (!await imageUsageService.IsUsedAsync(image, cancellationToken)) removableImages.Add(image);
		}

		try {
			await objectStorageService.DeleteManyAsync(removableImages, cancellationToken);
		} catch {
			// 图片清理失败不应影响文章删除结果；后续删除或人工清理可再次处理。
		}
	}

	private static IReadOnlyCollection<string> GetArticleImages(Domain.Blog.Article.Entities.Article article) =>
		ExtractImages(article.Content)
			.Append(article.Cover)
			.Where(image => !string.IsNullOrWhiteSpace(image))
			.Select(image => image.Trim())
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToArray();

	private static IReadOnlyCollection<string> ExtractImages(string markdown){
		if (string.IsNullOrWhiteSpace(markdown)) return [];

		return MarkdownImageRegex().Matches(markdown)
			.Select(match => match.Groups[1].Value)
			.Where(x => !string.IsNullOrWhiteSpace(x))
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToArray();
	}

	[GeneratedRegex("!\\[[^\\]]*\\]\\(([^)]+)\\)")]
	private static partial Regex MarkdownImageRegex();
}
