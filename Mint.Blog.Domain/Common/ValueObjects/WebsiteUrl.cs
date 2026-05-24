namespace Mint.Blog.Domain.Common.ValueObjects;

public sealed class WebsiteUrl : ValueObject {
	private WebsiteUrl(string value){
		Value = value;
	}

	public string Value { get; }

	public bool HasValue => !string.IsNullOrWhiteSpace(Value);

	public static WebsiteUrl Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Website url is required.", nameof(value));

		var normalizedValue = value.Trim();
		if (!Uri.TryCreate(normalizedValue, UriKind.Absolute, out _))
			throw new ArgumentException("Website url format is invalid.", nameof(value));

		return new WebsiteUrl(normalizedValue);
	}

	public static WebsiteUrl CreateOptional(string? value){
		if (string.IsNullOrWhiteSpace(value)) return new WebsiteUrl(string.Empty);
		return Create(value);
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
