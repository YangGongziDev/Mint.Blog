using System.Net.Mail;

namespace Mint.Blog.Domain.Common.ValueObjects;

public sealed class EmailAddress : ValueObject {
	private EmailAddress(string value){
		Value = value;
	}

	public string Value { get; }

	public bool HasValue => !string.IsNullOrWhiteSpace(Value);

	public static EmailAddress Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Email address is required.", nameof(value));

		var normalizedValue = value.Trim();
		if (!MailAddress.TryCreate(normalizedValue, out _))
			throw new ArgumentException("Email address format is invalid.", nameof(value));

		return new EmailAddress(normalizedValue);
	}

	public static EmailAddress CreateOptional(string? value){
		if (string.IsNullOrWhiteSpace(value)) return new EmailAddress(string.Empty);
		return Create(value);
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
