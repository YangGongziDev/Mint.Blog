using System.Collections.ObjectModel;
using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Infrastructure.Blog.Comment.SensitiveWords;

public sealed class SensitiveWordService : ISensitiveWordService {
	private readonly IReadOnlyCollection<string> _words;

	public SensitiveWordService(){
		var path = Path.Combine(AppContext.BaseDirectory, "Resources", "word", "sensi_words.txt");
		if (!File.Exists(path)) {
			_words = Array.Empty<string>();
			return;
		}

		_words = new ReadOnlyCollection<string>(File.ReadAllLines(path)
			.Select(line => line.Trim())
			.Where(line => !string.IsNullOrWhiteSpace(line))
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToArray());
	}

	public IReadOnlyCollection<string> FindMatchedWords(string content){
		if (string.IsNullOrWhiteSpace(content) || _words.Count == 0) return Array.Empty<string>();

		return _words
			.Where(word => content.Contains(word, StringComparison.OrdinalIgnoreCase))
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToArray();
	}
}