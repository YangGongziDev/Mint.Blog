namespace Mint.Blog.Application.Blog.Upload.Commands.UploadFile;

public sealed record UploadFileCommand(
	Stream FileStream,
	long FileLength,
	string FileName,
	string? ContentType,
	string? OldFileName);