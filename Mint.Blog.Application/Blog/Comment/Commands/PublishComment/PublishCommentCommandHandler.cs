using CommentEntity = Mint.Blog.Domain.Blog.Comment.Entities.Comment;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Comment.ValueObjects;
using Mint.Blog.Domain.Blog.Setting.Repositories;
using Mint.Blog.Domain.Blog.Comment.Repositories;
using Mint.Blog.Domain.Common.ValueObjects;

namespace Mint.Blog.Application.Blog.Comment.Commands.PublishComment;

public sealed class PublishCommentCommandHandler(
	ICommentRepository commentRepository,
	IBlogSettingRepository blogSettingRepository,
	ISensitiveWordService sensitiveWordService,
	IDomainEventDispatcher domainEventDispatcher) {
	private const int WaitExamineStatus = 1;
	private const int NormalStatus = 2;
	private const int ExamineFailedStatus = 3;

	public async Task<PublishCommentResult> HandleAsync(PublishCommentCommand command,
		CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Nickname), ErrorCodes.CommentNicknameInvalid,
			"Nickname is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Mail), ErrorCodes.CommentMailInvalid, "Mail is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.RouterUrl), ErrorCodes.CommentRouterUrlInvalid,
			"Router url is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Content), ErrorCodes.CommentContentInvalid,
			"Content is required.");

		var blogSetting = await blogSettingRepository.GetAsync(cancellationToken);
		var nickname = NormalizeNickname(command.Nickname);
		var mail = NormalizeMail(command.Mail);
		var normalizedContent = NormalizeContent(command.Content);
		var isCommentExamineOpen = blogSetting?.IsCommentExamineOpen ?? false;
		var isCommentSensitiveWordOpen = blogSetting?.IsCommentSensitiveWordOpen ?? false;
		var status = isCommentExamineOpen ? WaitExamineStatus : NormalStatus;
		var reason = string.Empty;

		if (isCommentSensitiveWordOpen) {
			var matchedKeywords = sensitiveWordService.FindMatchedWords(normalizedContent);
			if (matchedKeywords.Count > 0) {
				status = ExamineFailedStatus;
				reason = $"系统自动拦截，包含敏感词：[{string.Join(", ", matchedKeywords)}]";
			}
		}

		var comment = CommentEntity.Create(
			normalizedContent,
			command.Avatar.Trim(),
			nickname,
			mail,
			command.Website.Trim(),
			command.RouterUrl.Trim(),
			command.ReplyCommentId,
			command.ParentCommentId,
			status,
			reason);

		var commentId = await commentRepository.AddAsync(comment, cancellationToken);
		comment.MarkPublished(commentId);
		await domainEventDispatcher.DispatchAsync(comment.DomainEvents, cancellationToken);
		comment.ClearDomainEvents();

		if (status == ExamineFailedStatus)
			return new PublishCommentResult(false, ErrorCodes.CommentContainsSensitiveWord, "评论内容中包含敏感词，请重新编辑后再提交");

		if (status == WaitExamineStatus)
			return new PublishCommentResult(false, ErrorCodes.CommentWaitExamine, "评论已提交, 等待博主审核通过");

		return new PublishCommentResult(true);
	}

	private static string NormalizeNickname(string nickname){
		try {
			return Nickname.Create(nickname).Value;
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.CommentNicknameInvalid, "Nickname is invalid.");
		}
	}

	private static string NormalizeMail(string mail){
		try {
			return EmailAddress.Create(mail).Value;
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.CommentMailInvalid, "Mail format is invalid.");
		}
	}

	private static string NormalizeContent(string content){
		try {
			return CommentContent.Create(content).Value;
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.CommentContentInvalid,
				"Content length must be less than or equal to 120.");
		}
	}
}
