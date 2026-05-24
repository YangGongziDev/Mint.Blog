using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.RenameImage;

public sealed class RenameImageCommandHandler(
	IObjectStorageService objectStorageService,
	IImageReferenceUpdateService imageReferenceUpdateService) {
	public async Task<string> HandleAsync(RenameImageCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.OldImageName), ErrorCodes.FileUploadInvalid, "旧图片名称不能为空");
		Guard.Against(string.IsNullOrWhiteSpace(command.NewImageName), ErrorCodes.FileUploadInvalid, "新图片名称不能为空");

		var result = await objectStorageService.RenameAsync(command.OldImageName, command.NewImageName, cancellationToken);
		await imageReferenceUpdateService.ReplaceAsync(result.OldUrl, result.NewUrl, cancellationToken);

		return result.NewUrl;
	}
}
