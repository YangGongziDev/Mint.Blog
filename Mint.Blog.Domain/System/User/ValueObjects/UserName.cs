using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.System.User.ValueObjects;

public sealed class UserName : ValueObject {
	private const int MaxLength = 50;

	private UserName(string value){
		Value = value;
	}

	public string Value { get; }

	public static UserName Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("User name is required.", nameof(value));

		var normalizedValue = value.Trim();
		if (normalizedValue.Length > MaxLength)
			throw new ArgumentException($"User name length must be less than or equal to {MaxLength}.", nameof(value));

		return new UserName(normalizedValue);
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
