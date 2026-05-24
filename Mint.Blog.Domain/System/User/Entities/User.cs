using Mint.Blog.Domain.Common;
using Mint.Blog.Domain.System.User.ValueObjects;

namespace Mint.Blog.Domain.System.User.Entities;

public sealed class User : AggregateRoot<long> {
	public User(){
		UserName = null!;
		DisplayName = string.Empty;
		PasswordHash = null!;
		CreatedAt = DateTimeOffset.UtcNow;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	private User(long id, string userName, string displayName, string password, bool isDeleted, DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		Id = id;
		UserName = UserName.Create(userName);
		DisplayName = displayName;
		PasswordHash = PasswordHash.Create(password);
		IsDeleted = isDeleted;
		CreatedAt = createdAt;
		UpdatedAt = updatedAt;
	}

	public override long Id { get; protected set; }
	public UserName UserName { get; private set; }
	public string DisplayName { get; private set; }
	public PasswordHash PasswordHash { get; private set; }
	public bool IsDeleted { get; private set; }
	public DateTimeOffset CreatedAt { get; private set; }
	public DateTimeOffset UpdatedAt { get; private set; }

	public static User Rehydrate(long id, string userName, string displayName, string password, bool isDeleted,
		DateTimeOffset createdAt, DateTimeOffset updatedAt){
		return new User(id, userName, displayName, password, isDeleted, createdAt, updatedAt);
	}

	public void UpdateProfile(string userName, string displayName, bool isDeleted){
		var newUserName = UserName.Create(userName);
		var normalizedDisplayName = displayName.Trim();

		if (UserName.Value == newUserName.Value && DisplayName == normalizedDisplayName && IsDeleted == isDeleted) return;

		UserName = newUserName;
		DisplayName = normalizedDisplayName;
		IsDeleted = isDeleted;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void UpdatePassword(PasswordHash newPasswordHash){
		if (PasswordHash.Value == newPasswordHash.Value) return;

		PasswordHash = newPasswordHash;
		UpdatedAt = DateTimeOffset.UtcNow;
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
}
