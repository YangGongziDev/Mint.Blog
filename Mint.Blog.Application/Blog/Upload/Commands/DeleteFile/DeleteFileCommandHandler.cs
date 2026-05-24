using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.DeleteFile;

public sealed class DeleteFileCommandHandler(IObjectStorageService objectStorageService) {
	public async Task HandleAsync(DeleteFileCommand command, CancellationToken cancellationToken = default){
		if (string.IsNullOrWhiteSpace(command.OldFileName)) return;

		await objectStorageService.DeleteAsync(command.OldFileName, cancellationToken);
	}
}
