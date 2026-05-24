using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.ValueObjects;

public sealed class ArticleCover : ValueObject {
	private ArticleCover(string value){
		Value = value;
	}

	public string Value { get; }

	public static ArticleCover Create(string value){
		return new ArticleCover(value.Trim());
	}

	protected override IEnumerable<object?> GetEqualityComponents(){
		yield return Value;
	}

	public override string ToString() => Value;
}
