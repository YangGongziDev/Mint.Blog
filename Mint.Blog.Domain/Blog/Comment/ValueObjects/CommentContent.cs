using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Comment.ValueObjects;

public sealed class CommentContent : ValueObject {
	private const int MaxLength = 120;

	private CommentContent(string value){
		Value = value;
	}

	public string Value { get; }

	public static CommentContent Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Comment content is required.", nameof(value));

		var normalizedValue = value.Trim();
		if (normalizedValue.Length > MaxLength)
			throw new ArgumentException($"Comment content length must be less than or equal to {MaxLength}.", nameof(value));

		return new CommentContent(normalizedValue);
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
