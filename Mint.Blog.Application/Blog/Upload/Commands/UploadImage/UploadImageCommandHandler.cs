using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.UploadImage;

public sealed class UploadImageCommandHandler(
	IObjectStorageService objectStorageService,
	IImageUsageService imageUsageService) {
	public async Task<string> HandleAsync(UploadImageCommand command, CancellationToken cancellationToken = default){
		Guard.Against(command.FileStream is null || command.FileLength <= 0, ErrorCodes.FileUploadInvalid,
			"Image file is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.FileName), ErrorCodes.FileUploadInvalid,
			"Image file name is required.");

		var fileStream = command.FileStream!;

		if (!string.IsNullOrWhiteSpace(command.OldImageName) &&
		    !await imageUsageService.IsUsedAsync(command.OldImageName, cancellationToken))
			await objectStorageService.DeleteAsync(command.OldImageName, cancellationToken);

		return await objectStorageService.UploadAsync(
			fileStream,
			command.FileLength,
			command.FileName,
			command.ContentType,
			command.BucketName,
			cancellationToken);
	}
}