using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Message.Entities;

public sealed class Message : AggregateRoot<long> {
	public Message(){
		Nickname = string.Empty;
		Content = string.Empty;
		Color = string.Empty;
		CreatedAt = DateTimeOffset.UtcNow;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	private Message(
		long id,
		string nickname,
		string? email,
		string? website,
		string content,
		string color,
		bool isPublished,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		Id = id;
		Nickname = nickname;
		Email = email;
		Website = website;
		Content = content;
		Color = color;
		IsPublished = isPublished;
		CreatedAt = createdAt;
		UpdatedAt = updatedAt;
	}

	public override long Id { get; protected set; }
	public string Nickname { get; private set; }
	public string? Email { get; private set; }
	public string? Website { get; private set; }
	public string Content { get; private set; }
	public string Color { get; private set; }
	public bool IsPublished { get; private set; }
	public DateTimeOffset CreatedAt { get; private set; }
	public DateTimeOffset UpdatedAt { get; private set; }

	public static Message Create(
		string nickname,
		string? email,
		string? website,
		string content,
		string color){
		var now = DateTimeOffset.UtcNow;
		return new Message(0, nickname, email, website, content, color, true, now, now);
	}

	public static Message Rehydrate(
		long id,
		string nickname,
		string? email,
		string? website,
		string content,
		string color,
		bool isPublished,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		return new Message(id, nickname, email, website, content, color, isPublished, createdAt, updatedAt);
	}
}
