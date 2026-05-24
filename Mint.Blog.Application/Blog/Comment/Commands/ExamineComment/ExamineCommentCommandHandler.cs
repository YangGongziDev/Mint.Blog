using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Comment.Repositories;

namespace Mint.Blog.Application.Blog.Comment.Commands.ExamineComment;

public sealed class ExamineCommentCommandHandler(
	ICommentRepository commentRepository,
	IDomainEventDispatcher domainEventDispatcher) {
	public async Task HandleAsync(ExamineCommentCommand command, CancellationToken cancellationToken = default){
		var comment = await commentRepository.GetByIdAsync(command.Id, cancellationToken);
		Guard.Against(comment is null, ErrorCodes.CommentNotFound, "Comment does not exist.");

		try {
			comment!.Examine(command.Status, command.Reason);
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.CommentStatusInvalid, "Comment status is invalid.");
		}

		await commentRepository.UpdateAsync(comment, cancellationToken);
		await domainEventDispatcher.DispatchAsync(comment.DomainEvents, cancellationToken);
		comment.ClearDomainEvents();
	}
}
