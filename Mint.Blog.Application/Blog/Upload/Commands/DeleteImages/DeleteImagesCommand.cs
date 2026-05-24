namespace Mint.Blog.Application.Blog.Upload.Commands.DeleteImages;

public sealed record DeleteImagesCommand(IReadOnlyCollection<string> OldImageNames);