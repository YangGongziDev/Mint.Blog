using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Comment.Notifications;
using Mint.Blog.Domain.Blog.Setting.Repositories;
using Mint.Blog.Domain.Blog.Comment.Repositories;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Comment.Notifications;

public sealed class CommentNotificationService(
	ICommentRepository commentRepository,
	IBlogSettingRepository blogSettingRepository,
	IEmailSender emailSender,
	IOptions<CommentNotificationOptions> notificationOptions,
	ILogger<CommentNotificationService> logger) : ICommentNotificationService {
	private const int NormalStatus = 2;
	private const int ExamineFailedStatus = 3;

	public async Task NotifyCommentPublishedAsync(long commentId, CancellationToken cancellationToken = default){
		var comment = await commentRepository.GetByIdAsync(commentId, cancellationToken);
		var blogSetting = await blogSettingRepository.GetAsync(cancellationToken);
		if (comment is null || blogSetting is null) return;

		var domain = notificationOptions.Value.Domain;
		var blogName = blogSetting.Name;
		var authorMail = blogSetting.Mail;

		if (comment.ReplyCommentId.HasValue && comment.Status == NormalStatus) {
			var replyComment = await commentRepository.GetByIdAsync(comment.ReplyCommentId.Value, cancellationToken);
			if (replyComment is null || !replyComment.Mail.HasValue) return;

			var title = $"你在{blogName}的评论收到了回复";
			var html =
				$"<html><body><h2>你的评论:</h2><p>{replyComment.Content.Value}</p><h2>{comment.Nickname.Value} 回复了你:</h2><p>{comment.Content.Value}</p><p><a href='{domain}{replyComment.RouterUrl}' target='_blank'>查看详情</a></p></body></html>";
			await TrySendAsync(replyComment.Mail.Value, title, html, cancellationToken);
			return;
		}

		if (string.IsNullOrWhiteSpace(authorMail)) return;

		var titleToAuthor = $"{blogName}收到了评论";
		if (blogSetting.IsCommentExamineOpen && comment.Status == 1) titleToAuthor += "【待审核】";

		if (blogSetting.IsCommentSensitiveWordOpen && comment.Status == ExamineFailedStatus) titleToAuthor += "【系统已拦截】";

		var authorHtml =
			$"<html><body><h2>路由:</h2><p>{comment.RouterUrl}</p><h2>{comment.Nickname.Value} 评论了你:</h2><p>{comment.Content.Value}</p><p><a href='{domain}{comment.RouterUrl}' target='_blank'>查看详情</a></p></body></html>";
		await TrySendAsync(authorMail, titleToAuthor, authorHtml, cancellationToken);
	}

	public async Task NotifyCommentExaminedAsync(long commentId, CancellationToken cancellationToken = default){
		var comment = await commentRepository.GetByIdAsync(commentId, cancellationToken);
		var blogSetting = await blogSettingRepository.GetAsync(cancellationToken);
		if (comment is null || blogSetting is null || !comment.Mail.HasValue) return;

		var domain = notificationOptions.Value.Domain;
		var blogName = blogSetting.Name;

		if (comment.Status == ExamineFailedStatus) {
			var title = $"你在{blogName}的评论未被审核通过";
			var html =
				$"<html><body><h2>你的评论:</h2><p>{comment.Content.Value}</p><h2>审核未通过原因:</h2><p>{comment.Reason}</p><p><a href='{domain}{comment.RouterUrl}' target='_blank'>查看详情</a></p></body></html>";
			await TrySendAsync(comment.Mail.Value, title, html, cancellationToken);
			return;
		}

		if (comment.Status != NormalStatus) return;

		var approveTitle = $"你在{blogName}的评论已被审核通过";
		var approveHtml =
			$"<html><body><h2>你的评论:</h2><p>{comment.Content.Value}</p><p><a href='{domain}{comment.RouterUrl}' target='_blank'>查看详情</a></p></body></html>";
		await TrySendAsync(comment.Mail.Value, approveTitle, approveHtml, cancellationToken);

		if (!comment.ReplyCommentId.HasValue) return;

		var replyComment = await commentRepository.GetByIdAsync(comment.ReplyCommentId.Value, cancellationToken);
		if (replyComment is null || !replyComment.Mail.HasValue) return;

		var replyTitle = $"你在{blogName}的评论收到了回复";
		var replyHtml =
			$"<html><body><h2>你的评论:</h2><p>{replyComment.Content.Value}</p><h2>{comment.Nickname.Value} 回复了你:</h2><p>{comment.Content.Value}</p><p><a href='{domain}{replyComment.RouterUrl}' target='_blank'>查看详情</a></p></body></html>";
		await TrySendAsync(replyComment.Mail.Value, replyTitle, replyHtml, cancellationToken);
	}

	private async Task TrySendAsync(string to, string title, string html, CancellationToken cancellationToken){
		try {
			await emailSender.SendHtmlAsync(to, title, html, cancellationToken);
		} catch (Exception exception) {
			logger.LogError(exception, "Failed to send comment notification email. to={To}, title={Title}", to, title);
		}
	}
}
