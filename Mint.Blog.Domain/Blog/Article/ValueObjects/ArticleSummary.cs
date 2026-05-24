using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.ValueObjects;

public sealed class ArticleSummary : ValueObject {
	private ArticleSummary(string value){
		Value = value;
	}

	public string Value { get; }

	public static ArticleSummary Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Article summary is required.", nameof(value));

		return new ArticleSummary(value.Trim());
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
