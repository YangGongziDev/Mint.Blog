namespace Mint.Blog.Application.Blog.Upload.Commands.MoveImages;

public sealed record MoveImagesCommand(IReadOnlyCollection<string> OldImageNames, string TargetBucketName, bool OverwriteExisting = false);
