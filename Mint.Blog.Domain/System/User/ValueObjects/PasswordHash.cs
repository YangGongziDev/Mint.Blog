using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.System.User.ValueObjects;

public sealed class PasswordHash : ValueObject {
	private PasswordHash(string value){
		Value = value;
	}

	public string Value { get; }

	public static PasswordHash Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Password hash is required.", nameof(value));

		return new PasswordHash(value.Trim());
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
