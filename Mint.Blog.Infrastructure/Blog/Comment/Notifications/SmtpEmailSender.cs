using System.Net;
using System.Net.Mail;
using Microsoft.Extensions.Options;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Comment.Notifications;

public sealed class SmtpEmailSender(IOptions<SmtpOptions> smtpOptions) : IEmailSender {
	public async Task<bool> SendHtmlAsync(string to, string title, string html,
		CancellationToken cancellationToken = default){
		var options = smtpOptions.Value;
		if (string.IsNullOrWhiteSpace(options.Host) || string.IsNullOrWhiteSpace(options.From)) return false;

		using var client = new SmtpClient(options.Host, options.Port) {
			EnableSsl = options.EnableSsl,
			Credentials = new NetworkCredential(options.UserName, options.Password)
		};

		using var message = new MailMessage(options.From, to, title, html) {
			IsBodyHtml = true
		};

		await client.SendMailAsync(message, cancellationToken);
		return true;
	}
}