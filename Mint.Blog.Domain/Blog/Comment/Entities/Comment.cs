using Mint.Blog.Domain.Blog.Comment.ValueObjects;
using Mint.Blog.Domain.Blog.Comment.Events;
using Mint.Blog.Domain.Common;
using Mint.Blog.Domain.Common.ValueObjects;

namespace Mint.Blog.Domain.Blog.Comment.Entities;

public sealed class Comment : AggregateRoot<long> {
	private const int WaitExamineStatus = 1;
	private const int NormalStatus = 2;
	private const int ExamineFailedStatus = 3;

	public Comment(){
		Content = null!;
		Avatar = string.Empty;
		Nickname = null!;
		Mail = null!;
		Website = null!;
		RouterUrl = string.Empty;
		Reason = string.Empty;
		CreatedAt = DateTimeOffset.UtcNow;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	private Comment(
		long id,
		string content,
		string avatar,
		string nickname,
		string mail,
		string website,
		string routerUrl,
		bool isDeleted,
		long? replyCommentId,
		long? parentCommentId,
		int status,
		string reason,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		Id = id;
		Content = CommentContent.Create(content);
		Avatar = avatar;
		Nickname = Nickname.Create(nickname);
		Mail = EmailAddress.Create(mail);
		Website = WebsiteUrl.CreateOptional(website);
		RouterUrl = routerUrl;
		IsDeleted = isDeleted;
		ReplyCommentId = replyCommentId;
		ParentCommentId = parentCommentId;
		Status = status;
		Reason = reason;
		CreatedAt = createdAt;
		UpdatedAt = updatedAt;
	}

	public override long Id { get; protected set; }
	public CommentContent Content { get; private set; }
	public string Avatar { get; private set; }
	public Nickname Nickname { get; private set; }
	public EmailAddress Mail { get; private set; }
	public WebsiteUrl Website { get; private set; }
	public string RouterUrl { get; private set; }
	public bool IsDeleted { get; private set; }
	public long? ReplyCommentId { get; private set; }
	public long? ParentCommentId { get; private set; }
	public int Status { get; private set; }
	public string Reason { get; private set; }
	public DateTimeOffset CreatedAt { get; private set; }
	public DateTimeOffset UpdatedAt { get; private set; }

	public static Comment Create(
		string content,
		string avatar,
		string nickname,
		string mail,
		string website,
		string routerUrl,
		long? replyCommentId,
		long? parentCommentId,
		int status,
		string reason){
		var now = DateTimeOffset.UtcNow;
		return new Comment(0, content, avatar, nickname, mail, website, routerUrl, false, replyCommentId,
			parentCommentId, status, reason, now, now);
	}

	public static Comment Rehydrate(
		long id,
		string content,
		string avatar,
		string nickname,
		string mail,
		string website,
		string routerUrl,
		bool isDeleted,
		long? replyCommentId,
		long? parentCommentId,
		int status,
		string reason,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		return new Comment(id, content, avatar, nickname, mail, website, routerUrl, isDeleted, replyCommentId,
			parentCommentId, status, reason, createdAt, updatedAt);
	}

	public void Examine(int status, string? reason){
		ValidateStatus(status);

		if (status == WaitExamineStatus)
			throw new ArgumentException("Comment examine status is invalid.", nameof(status));

		Status = status;
		Reason = status == ExamineFailedStatus ? (reason?.Trim() ?? string.Empty) : string.Empty;
		UpdatedAt = DateTimeOffset.UtcNow;
		AddDomainEvent(new CommentExaminedDomainEvent(Id, Status, UpdatedAt));
	}

	public void MarkPublished(long id){
		ArgumentOutOfRangeException.ThrowIfNegativeOrZero(id);

		Id = id;
		AddDomainEvent(new CommentPublishedDomainEvent(Id, Status, CreatedAt));
	}

	public void MarkDeleted(){
		if (IsDeleted) return;

		IsDeleted = true;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void Restore(){
		if (!IsDeleted) return;

		IsDeleted = false;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	private static void ValidateStatus(int status){
		if (status is not WaitExamineStatus and not NormalStatus and not ExamineFailedStatus)
			throw new ArgumentException("Comment status is invalid.", nameof(status));
	}
}
