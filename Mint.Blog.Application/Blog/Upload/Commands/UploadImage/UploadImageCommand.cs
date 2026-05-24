namespace Mint.Blog.Application.Blog.Upload.Commands.UploadImage;

public sealed record UploadImageCommand(
	Stream FileStream,
	long FileLength,
	string FileName,
	string? ContentType,
	string? OldImageName,
	string? BucketName = null);