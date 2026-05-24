using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Comment.Repositories;

namespace Mint.Blog.Application.Blog.Comment.Commands.DeleteComment;

public sealed class DeleteCommentCommandHandler(ICommentRepository commentRepository) {
	public async Task HandleAsync(DeleteCommentCommand command, CancellationToken cancellationToken = default){
		Guard.Against(command.DeleteType is not 1 and not 2 and not 3, ErrorCodes.DeleteTypeInvalid,
			"Delete type is invalid.");

		var comment = await commentRepository.GetByIdIncludingDeletedAsync(command.Id, cancellationToken);
		Guard.Against(comment is null, ErrorCodes.CommentNotFound, "Comment does not exist.");

		if (command.DeleteType == 1 || command.DeleteType == 3) {
			if (command.DeleteType == 1)
				comment!.MarkDeleted();
			else
				comment!.Restore();

			await commentRepository.UpdateAsync(comment, cancellationToken);
			return;
		}

		await commentRepository.DeleteAsync(command.Id, cancellationToken);

		var allComments = await commentRepository.GetAllAsync(cancellationToken);
		var replyChildren = allComments
			.Where(item => item.ReplyCommentId == command.Id)
			.OrderByDescending(item => item.CreatedAt)
			.ToArray();

		if (comment!.ReplyCommentId is null) {
			var parentChildren = allComments
				.Where(item => item.ParentCommentId == command.Id)
				.ToArray();

			foreach (var child in parentChildren) await commentRepository.DeleteAsync(child.Id, cancellationToken);

			return;
		}

		foreach (var child in replyChildren) {
			await commentRepository.DeleteAsync(child.Id, cancellationToken);
			await DeleteAllChildCommentAsync(child.Id, cancellationToken);
		}
	}

	private async Task DeleteAllChildCommentAsync(long commentId, CancellationToken cancellationToken){
		var allComments = await commentRepository.GetAllAsync(cancellationToken);
		var childComments = allComments
			.Where(item => item.ReplyCommentId == commentId)
			.OrderByDescending(item => item.CreatedAt)
			.ToArray();

		foreach (var child in childComments) {
			await commentRepository.DeleteAsync(child.Id, cancellationToken);
			await DeleteAllChildCommentAsync(child.Id, cancellationToken);
		}
	}
}
