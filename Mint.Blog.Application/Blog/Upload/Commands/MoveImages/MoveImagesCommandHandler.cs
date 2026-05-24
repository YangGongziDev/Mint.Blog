using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.MoveImages;

public sealed class MoveImagesCommandHandler(
	IObjectStorageService objectStorageService,
	IImageReferenceUpdateService imageReferenceUpdateService) {
	public async Task<MoveImagesPrecheckResult> PrecheckAsync(MoveImagesPrecheckCommand command,
		CancellationToken cancellationToken = default){
		Guard.Against(command.OldImageNames.Count == 0, ErrorCodes.FileUploadInvalid, "请选择要移动的图片");
		Guard.Against(string.IsNullOrWhiteSpace(command.TargetBucketName), ErrorCodes.FileUploadInvalid, "目标桶名称不能为空");

		var distinctImageNames = command.OldImageNames
			.Where(x => !string.IsNullOrWhiteSpace(x))
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToArray();
		var conflicts = await objectStorageService.GetMoveConflictsAsync(distinctImageNames, command.TargetBucketName,
			cancellationToken);
		return new MoveImagesPrecheckResult(conflicts);
	}

	public async Task<IReadOnlyCollection<string>> HandleAsync(MoveImagesCommand command, CancellationToken cancellationToken = default){
		Guard.Against(command.OldImageNames.Count == 0, ErrorCodes.FileUploadInvalid, "请选择要移动的图片");
		Guard.Against(string.IsNullOrWhiteSpace(command.TargetBucketName), ErrorCodes.FileUploadInvalid, "目标桶名称不能为空");

		var newUrls = new List<string>();
		foreach (var imageName in command.OldImageNames.Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase)) {
			var result = await objectStorageService.MoveToBucketAsync(imageName, command.TargetBucketName,
				command.OverwriteExisting, cancellationToken);
			await imageReferenceUpdateService.ReplaceAsync(result.OldUrl, result.NewUrl, cancellationToken);
			newUrls.Add(result.NewUrl);
		}

		return newUrls;
	}
}
