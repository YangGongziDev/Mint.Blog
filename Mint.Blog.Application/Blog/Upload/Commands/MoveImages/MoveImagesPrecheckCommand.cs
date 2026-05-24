namespace Mint.Blog.Application.Blog.Upload.Commands.MoveImages;

public sealed record MoveImagesPrecheckCommand(IReadOnlyCollection<string> OldImageNames, string TargetBucketName);
