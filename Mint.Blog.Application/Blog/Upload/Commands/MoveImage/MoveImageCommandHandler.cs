using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.MoveImage;

public sealed class MoveImageCommandHandler(
	IObjectStorageService objectStorageService,
	IImageReferenceUpdateService imageReferenceUpdateService) {
	public async Task<string> HandleAsync(MoveImageCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.OldImageName), ErrorCodes.FileUploadInvalid, "旧图片名称不能为空");
		Guard.Against(string.IsNullOrWhiteSpace(command.TargetBucketName), ErrorCodes.FileUploadInvalid, "目标桶名称不能为空");

		var result = await objectStorageService.MoveToBucketAsync(command.OldImageName, command.TargetBucketName, false, cancellationToken);
		await imageReferenceUpdateService.ReplaceAsync(result.OldUrl, result.NewUrl, cancellationToken);

		return result.NewUrl;
	}
}
