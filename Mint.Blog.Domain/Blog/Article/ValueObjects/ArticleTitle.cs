using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.ValueObjects;

public sealed class ArticleTitle : ValueObject {
	private ArticleTitle(string value){
		Value = value;
	}

	public string Value { get; }

	public static ArticleTitle Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Article title is required.", nameof(value));

		return new ArticleTitle(value.Trim());
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
