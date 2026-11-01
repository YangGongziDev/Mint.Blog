namespace Mint.Blog.Model.Dtos.Blog.Upload;

public sealed record UploadFileCommand(Stream FileStream, long FileLength, string FileName, string? ContentType, string? OldFileName);
public sealed record UploadImageCommand(Stream FileStream, long FileLength, string FileName, string? ContentType, string? OldImageName, string? BucketName = null);
public sealed record DeleteFileCommand(string? OldFileName);
public sealed record DeleteImageCommand(string? OldImageName);
public sealed record DeleteImagesCommand(IReadOnlyCollection<string> OldImageNames);
public sealed record RenameImageCommand(string OldImageName, string NewImageName);
public sealed record MoveImageCommand(string OldImageName, string TargetBucketName);
public sealed record MoveImagesCommand(IReadOnlyCollection<string> OldImageNames, string TargetBucketName, bool OverwriteExisting = false);
public sealed record MoveImagesPrecheckCommand(IReadOnlyCollection<string> OldImageNames, string TargetBucketName);
public sealed record ManagedImageListQuery(int PageNumber = 1, int PageSize = 20, string? BucketName = null, string? FileName = null, bool? Used = null, string? SortOrder = null);
