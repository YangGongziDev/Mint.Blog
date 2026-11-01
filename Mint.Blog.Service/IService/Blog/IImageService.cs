using Mint.Blog.Common.Storage;
using Mint.Blog.Model.Dtos.Blog.Upload;
using Mint.Blog.Model.Vos.Blog.Upload;

namespace Mint.Blog.Service.IService.Blog;

public interface IImageService {
    Task<string> UploadAsync(UploadFileCommand command, CancellationToken cancellationToken = default);
    Task<string> UploadAsync(UploadImageCommand command, CancellationToken cancellationToken = default);
    Task DeleteAsync(DeleteFileCommand command, CancellationToken cancellationToken = default);
    Task DeleteAsync(DeleteImageCommand command, CancellationToken cancellationToken = default);
    Task<DeleteImagesResult> DeleteAsync(DeleteImagesCommand command, CancellationToken cancellationToken = default);
    Task<string> RenameAsync(RenameImageCommand command, CancellationToken cancellationToken = default);
    Task<string> MoveAsync(MoveImageCommand command, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<string>> MoveAsync(MoveImagesCommand command, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<ObjectMoveConflict>> PrecheckAsync(MoveImagesPrecheckCommand command, CancellationToken cancellationToken = default);
}
