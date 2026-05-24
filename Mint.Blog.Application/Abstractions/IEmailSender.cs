namespace Mint.Blog.Application.Abstractions;

public interface IEmailSender {
	Task<bool> SendHtmlAsync(string to, string title, string html, CancellationToken cancellationToken = default);
}