namespace Mint.Blog.Application.Blog.Upload.Commands.MoveImage;

public sealed record MoveImageCommand(string OldImageName, string TargetBucketName);
