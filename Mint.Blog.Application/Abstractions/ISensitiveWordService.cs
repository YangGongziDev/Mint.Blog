namespace Mint.Blog.Application.Abstractions;

public interface ISensitiveWordService {
	IReadOnlyCollection<string> FindMatchedWords(string content);
}