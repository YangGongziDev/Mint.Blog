namespace Mint.Blog.Common.Email;

public interface IEmailSender {
    Task<bool> SendHtmlAsync(string to, string title, string html, CancellationToken cancellationToken = default);
}
