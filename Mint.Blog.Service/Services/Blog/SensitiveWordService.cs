using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class SensitiveWordService : ISensitiveWordService {
    private readonly IReadOnlyCollection<string> _words;
    public SensitiveWordService() {
        var path = Path.Combine(AppContext.BaseDirectory, "Resources", "word", "sensi_words.txt");
        _words = File.Exists(path) ? File.ReadAllLines(path).Select(x => x.Trim()).Where(x => !string.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase).ToArray() : [];
    }
    public IReadOnlyCollection<string> FindMatchedWords(string content) => string.IsNullOrWhiteSpace(content) || _words.Count == 0 ? [] :
        _words.Where(x => content.Contains(x, StringComparison.OrdinalIgnoreCase)).Distinct(StringComparer.OrdinalIgnoreCase).ToArray();
}
