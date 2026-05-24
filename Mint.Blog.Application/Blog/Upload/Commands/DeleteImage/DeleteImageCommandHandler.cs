using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.DeleteImage;

public sealed class DeleteImageCommandHandler(
	IObjectStorageService objectStorageService,
	IImageUsageService imageUsageService) {
	public async Task HandleAsync(DeleteImageCommand command, CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(command.OldImageName)) return;
		if (await imageUsageService.IsUsedAsync(command.OldImageName, cancellationToken))
			throw new BusinessException(ErrorCodes.FileUploadInvalid, "图片正在被文章引用，不能删除");

		await objectStorageService.DeleteAsync(command.OldImageName, cancellationToken);
	}
}