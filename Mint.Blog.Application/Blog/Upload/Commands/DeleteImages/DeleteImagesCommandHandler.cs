using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.DeleteImages;

public sealed class DeleteImagesCommandHandler(
	IObjectStorageService objectStorageService,
	IImageUsageService imageUsageService) {
	public async Task<DeleteImagesResult> HandleAsync(DeleteImagesCommand command, CancellationToken cancellationToken = default){
		if (command.OldImageNames.Count == 0) return new DeleteImagesResult(0, 0);

		var removableImages = new List<string>();
		var skippedUsedCount = 0;
		foreach (var imageName in command.OldImageNames.Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase)) {
			if (await imageUsageService.IsUsedAsync(imageName, cancellationToken)) {
				skippedUsedCount += 1;
				continue;
			}

			removableImages.Add(imageName);
		}

		await objectStorageService.DeleteManyAsync(removableImages, cancellationToken);
		return new DeleteImagesResult(removableImages.Count, skippedUsedCount);
	}
}