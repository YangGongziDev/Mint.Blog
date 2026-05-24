namespace Mint.Blog.Domain.Common.ValueObjects;

public sealed class Nickname : ValueObject {
	private const int MaxLength = 50;

	private Nickname(string value){
		Value = value;
	}

	public string Value { get; }

	public static Nickname Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Nickname is required.", nameof(value));

		var normalizedValue = value.Trim();
		if (normalizedValue.Length > MaxLength)
			throw new ArgumentException($"Nickname length must be less than or equal to {MaxLength}.", nameof(value));

		return new Nickname(normalizedValue);
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
