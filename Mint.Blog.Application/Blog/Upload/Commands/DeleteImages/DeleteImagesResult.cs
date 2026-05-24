namespace Mint.Blog.Application.Blog.Upload.Commands.DeleteImages;

public sealed record DeleteImagesResult(int DeletedCount, int SkippedUsedCount);
