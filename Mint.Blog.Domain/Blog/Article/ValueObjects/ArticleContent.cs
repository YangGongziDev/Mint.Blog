using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.ValueObjects;

public sealed class ArticleContent : ValueObject {
	private ArticleContent(string value){
		Value = value;
	}

	public string Value { get; }

	public static ArticleContent Create(string value){
		if (string.IsNullOrWhiteSpace(value))
			throw new ArgumentException("Article content is required.", nameof(value));

		return new ArticleContent(value.Trim());
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
