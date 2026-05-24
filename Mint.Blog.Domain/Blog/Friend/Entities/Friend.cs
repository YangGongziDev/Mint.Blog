using Mint.Blog.Domain.Common;
using Mint.Blog.Domain.Blog.Friend.Events;
using Mint.Blog.Domain.Common.ValueObjects;

namespace Mint.Blog.Domain.Blog.Friend.Entities;

public sealed class Friend : AggregateRoot<long> {
	public Friend(){
		Name = string.Empty;
		Description = string.Empty;
		Url = null!;
		Avatar = string.Empty;
		Status = string.Empty;
		Category = string.Empty;
		Email = null!;
		CreatedAt = DateTimeOffset.UtcNow;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	private Friend(
		long id,
		string name,
		string description,
		string url,
		string avatar,
		string status,
		string category,
		bool isTop,
		string email,
		int sort,
		bool isDeleted,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		Id = id;
		Name = name;
		Description = description;
		Url = WebsiteUrl.Create(url);
		Avatar = avatar;
		Status = status;
		Category = category;
		IsTop = isTop;
		Email = EmailAddress.CreateOptional(email);
		Sort = sort;
		IsDeleted = isDeleted;
		CreatedAt = createdAt;
		UpdatedAt = updatedAt;
	}

	public override long Id { get; protected set; }
	public string Name { get; private set; }
	public string Description { get; private set; }
	public WebsiteUrl Url { get; private set; }
	public string Avatar { get; private set; }
	public string Status { get; private set; }
	public string Category { get; private set; }
	public bool IsTop { get; private set; }
	public EmailAddress Email { get; private set; }
	public int Sort { get; private set; }
	public bool IsDeleted { get; private set; }
	public DateTimeOffset CreatedAt { get; private set; }
	public DateTimeOffset UpdatedAt { get; private set; }

	public static Friend Create(string name, string avatar, string category, string url, string description,
		string email){
		var now = DateTimeOffset.UtcNow;
		var friend = new Friend(0, NormalizeRequired(name), NormalizeRequired(description), url,
			NormalizeRequired(avatar), "pending", NormalizeRequired(category), false, email, 0, false, now, now);
		friend.AddDomainEvent(new FriendAppliedDomainEvent(friend.Id, now));
		return friend;
	}

	public static Friend CreateAdmin(string name, string avatar, string category, string url, string description,
		string email){
		var now = DateTimeOffset.UtcNow;
		return new Friend(0, NormalizeRequired(name), NormalizeRequired(description), url, NormalizeRequired(avatar),
			"active", NormalizeRequired(category), false, email, 0, false, now, now);
	}

	public void UpdateProfile(string name, string avatar, string category, string url, string description, string email){
		Name = NormalizeRequired(name);
		Avatar = NormalizeRequired(avatar);
		Category = NormalizeRequired(category);
		Url = WebsiteUrl.Create(url);
		Description = NormalizeRequired(description);
		Email = EmailAddress.CreateOptional(email);
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void SetStatus(string status){
		var normalizedStatus = NormalizeStatus(status);
		if (Status == normalizedStatus) return;

		Status = normalizedStatus;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void SetTop(bool isTop){
		if (IsTop == isTop) return;

		IsTop = isTop;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void UpdateSort(int sort){
		Sort = sort;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void MoveSortFirst(int currentMaxSort){
		UpdateSort((currentMaxSort < 0 ? 0 : currentMaxSort) + 1);
	}

	public void MoveSortLast(int? currentMinSort){
		var nextSort = currentMinSort is null ? 0 : Math.Max(0, currentMinSort.Value - 1);
		UpdateSort(nextSort);
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

	public static Friend Rehydrate(
		long id,
		string name,
		string description,
		string url,
		string avatar,
		string status,
		string category,
		bool isTop,
		string email,
		int sort,
		bool isDeleted,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		return new Friend(id, name, description, url, avatar, status, category, isTop, email, sort, isDeleted,
			createdAt, updatedAt);
	}

	private static string NormalizeRequired(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Value is required.", nameof(value));

		return value.Trim();
	}

	private static string NormalizeStatus(string value){
		var normalizedValue = NormalizeRequired(value).ToLowerInvariant();

		if (normalizedValue is not "active" and not "inactive" and not "pending")
			throw new ArgumentException("Friend status is invalid.", nameof(value));

		return normalizedValue;
	}
}
