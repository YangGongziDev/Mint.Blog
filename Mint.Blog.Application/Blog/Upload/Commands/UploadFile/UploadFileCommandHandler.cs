using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.UploadFile;

public sealed class UploadFileCommandHandler(IObjectStorageService objectStorageService) {
	public async Task<string> HandleAsync(UploadFileCommand command, CancellationToken cancellationToken = default){
		Guard.Against(command.FileStream is null || command.FileLength <= 0, ErrorCodes.FileUploadInvalid,
			"File is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.FileName), ErrorCodes.FileUploadInvalid,
			"File name is required.");

		var fileStream = command.FileStream!;

		if (!string.IsNullOrWhiteSpace(command.OldFileName))
			await objectStorageService.DeleteAsync(command.OldFileName, cancellationToken);

		return await objectStorageService.UploadAsync(
			fileStream,
			command.FileLength,
			command.FileName,
			command.ContentType,
			cancellationToken);
	}
}