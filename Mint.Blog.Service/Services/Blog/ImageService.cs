using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Common.Storage;
using Mint.Blog.Model.Dtos.Blog.Upload;
using Mint.Blog.Model.Vos.Blog.Upload;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class ImageService(IObjectStorageService objectStorageService, IImageRepository imageRepository) : IImageService {
    public async Task<string> UploadAsync(UploadFileCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.FileStream is null || command.FileLength <= 0, ErrorCodes.FileUploadInvalid, "File is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.FileName), ErrorCodes.FileUploadInvalid, "File name is required.");
        if (!string.IsNullOrWhiteSpace(command.OldFileName)) await objectStorageService.DeleteAsync(command.OldFileName, cancellationToken);
        return await objectStorageService.UploadAsync(command.FileStream!, command.FileLength, command.FileName, command.ContentType, cancellationToken);
    }
    public async Task<string> UploadAsync(UploadImageCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.FileStream is null || command.FileLength <= 0, ErrorCodes.FileUploadInvalid, "Image file is required.");
        Guard.Against(string.IsNullOrWhiteSpace(command.FileName), ErrorCodes.FileUploadInvalid, "Image file name is required.");
        if (!string.IsNullOrWhiteSpace(command.OldImageName) && !await IsUsedAsync(command.OldImageName, cancellationToken))
            await objectStorageService.DeleteAsync(command.OldImageName, cancellationToken);
        return await objectStorageService.UploadAsync(command.FileStream!, command.FileLength, command.FileName, command.ContentType, command.BucketName, cancellationToken);
    }
    public Task DeleteAsync(DeleteFileCommand command, CancellationToken cancellationToken = default) =>
        string.IsNullOrWhiteSpace(command.OldFileName) ? Task.CompletedTask : objectStorageService.DeleteAsync(command.OldFileName, cancellationToken);
    public async Task DeleteAsync(DeleteImageCommand command, CancellationToken cancellationToken = default) {
        if (string.IsNullOrWhiteSpace(command.OldImageName)) return;
        if (await IsUsedAsync(command.OldImageName, cancellationToken)) throw new BusinessException(ErrorCodes.FileUploadInvalid, "图片正在被文章引用，不能删除");
        await objectStorageService.DeleteAsync(command.OldImageName, cancellationToken);
    }
    public async Task<DeleteImagesResult> DeleteAsync(DeleteImagesCommand command, CancellationToken cancellationToken = default) {
        if (command.OldImageNames.Count == 0) return new DeleteImagesResult(0, 0);
        var removable = new List<string>();
        var skipped = 0;
        foreach (var name in command.OldImageNames.Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase)) {
            if (await IsUsedAsync(name, cancellationToken)) { skipped += 1; continue; }
            removable.Add(name);
        }
        await objectStorageService.DeleteManyAsync(removable, cancellationToken);
        return new DeleteImagesResult(removable.Count, skipped);
    }
    public async Task<string> RenameAsync(RenameImageCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.OldImageName), ErrorCodes.FileUploadInvalid, "旧图片名称不能为空");
        Guard.Against(string.IsNullOrWhiteSpace(command.NewImageName), ErrorCodes.FileUploadInvalid, "新图片名称不能为空");
        var result = await objectStorageService.RenameAsync(command.OldImageName, command.NewImageName, cancellationToken);
        await ReplaceAsync(result.OldUrl, result.NewUrl, cancellationToken);
        return result.NewUrl;
    }
    public async Task<string> MoveAsync(MoveImageCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.OldImageName), ErrorCodes.FileUploadInvalid, "旧图片名称不能为空");
        Guard.Against(string.IsNullOrWhiteSpace(command.TargetBucketName), ErrorCodes.FileUploadInvalid, "目标桶名称不能为空");
        var result = await objectStorageService.MoveToBucketAsync(command.OldImageName, command.TargetBucketName, false, cancellationToken);
        await ReplaceAsync(result.OldUrl, result.NewUrl, cancellationToken);
        return result.NewUrl;
    }
    public async Task<IReadOnlyCollection<string>> MoveAsync(MoveImagesCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.OldImageNames.Count == 0, ErrorCodes.FileUploadInvalid, "请选择要移动的图片");
        Guard.Against(string.IsNullOrWhiteSpace(command.TargetBucketName), ErrorCodes.FileUploadInvalid, "目标桶名称不能为空");
        var urls = new List<string>();
        foreach (var name in command.OldImageNames.Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase)) {
            var result = await objectStorageService.MoveToBucketAsync(name, command.TargetBucketName, command.OverwriteExisting, cancellationToken);
            await ReplaceAsync(result.OldUrl, result.NewUrl, cancellationToken);
            urls.Add(result.NewUrl);
        }
        return urls;
    }
    public Task<IReadOnlyCollection<ObjectMoveConflict>> PrecheckAsync(MoveImagesPrecheckCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.OldImageNames.Count == 0, ErrorCodes.FileUploadInvalid, "请选择要移动的图片");
        Guard.Against(string.IsNullOrWhiteSpace(command.TargetBucketName), ErrorCodes.FileUploadInvalid, "目标桶名称不能为空");
        return objectStorageService.GetMoveConflictsAsync(command.OldImageNames.Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase).ToArray(), command.TargetBucketName, cancellationToken);
    }
    private Task<bool> IsUsedAsync(string image, CancellationToken ct) => string.IsNullOrWhiteSpace(image) ? Task.FromResult(false) : imageRepository.IsUsedAsync(image.Trim(), ct);
    private async Task ReplaceAsync(string oldUrl, string newUrl, CancellationToken ct) {
        if (string.IsNullOrWhiteSpace(oldUrl) || string.IsNullOrWhiteSpace(newUrl) || oldUrl == newUrl) return;
        await imageRepository.ReplaceArticleCoversAsync(oldUrl, newUrl, ct);
        foreach (var content in await imageRepository.GetArticleContentsAsync(oldUrl, ct)) {
            content.Content = content.Content.Replace(oldUrl, newUrl, StringComparison.Ordinal);
            await imageRepository.UpdateArticleContentAsync(content, ct);
        }
        await imageRepository.ReplaceDraftCoversAsync(oldUrl, newUrl, ct);
        foreach (var content in await imageRepository.GetDraftContentsAsync(oldUrl, ct)) {
            content.Content = content.Content.Replace(oldUrl, newUrl, StringComparison.Ordinal);
            await imageRepository.UpdateDraftContentAsync(content, ct);
        }
        foreach (var setting in await imageRepository.GetSettingsAsync(oldUrl, ct)) {
            if (setting.Logo == oldUrl) setting.Logo = newUrl;
            if (setting.Avatar == oldUrl) setting.Avatar = newUrl;
            await imageRepository.UpdateSettingAsync(setting, ct);
        }
    }
}
