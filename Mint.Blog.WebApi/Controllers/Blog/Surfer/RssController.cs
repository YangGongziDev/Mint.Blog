using System.Globalization;
using System.Net.Mail;
using System.Text;
using System.Text.Encodings.Web;
using System.Xml;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Mint.Blog.Service.IService.Blog;
using Mint.Blog.Model.Options;

namespace Mint.Blog.WebApi.Controllers.Blog.Surfer;

[ApiController]
[AllowAnonymous]
[Route("api/rss")]
public sealed class RssController(
	IPublicArticleService articles,
	IBlogSettingService settings,
	IOptions<SiteOptions> siteOptions) : ControllerBase {
	private const string ContentNamespace = "http://purl.org/rss/1.0/modules/content/";
	private const string CreatorNamespace = "http://purl.org/dc/elements/1.1/";
	private const string AtomNamespace = "http://www.w3.org/2005/Atom";

	[HttpGet]
	[Produces("application/rss+xml")]
	public async Task<IActionResult> Get(CancellationToken cancellationToken){
		var siteUrl = new Uri(siteOptions.Value.Url.TrimEnd('/') + "/", UriKind.Absolute);
		var site = await settings.GetAsync(cancellationToken);
		var items = await articles.GetRssAsync(cancellationToken);
		var title = string.IsNullOrWhiteSpace(site?.Name) ? "Mint.Blog" : site.Name;
		var author = site?.Author?.Trim();
		var mail = site?.Mail?.Trim();
		var hasMail = MailAddress.TryCreate(mail, out var address)
		              && string.Equals(address.Address, mail, StringComparison.OrdinalIgnoreCase);

		using var stream = new MemoryStream();
		using (var writer = XmlWriter.Create(stream, new XmlWriterSettings {
			Encoding = new UTF8Encoding(false),
			Indent = true
		})) {
			writer.WriteStartDocument();
			writer.WriteStartElement("rss");
			writer.WriteAttributeString("version", "2.0");
			writer.WriteAttributeString("xmlns", "content", null, ContentNamespace);
			writer.WriteAttributeString("xmlns", "dc", null, CreatorNamespace);
			writer.WriteAttributeString("xmlns", "atom", null, AtomNamespace);
			writer.WriteStartElement("channel");
			writer.WriteElementString("title", title);
			writer.WriteElementString("link", siteUrl.AbsoluteUri);
			writer.WriteElementString("description", site?.Introduction ?? title);
			writer.WriteElementString("language", "zh-CN");
			writer.WriteElementString("generator", "Mint.Blog");
			if (!string.IsNullOrWhiteSpace(site?.CopyrightDeclaration))
				writer.WriteElementString("copyright", site.CopyrightDeclaration);
			if (items.Count > 0)
				writer.WriteElementString("lastBuildDate",
					items.Max(x => x.UpdatedAt).UtcDateTime.ToString("R", CultureInfo.InvariantCulture));
			if (!string.IsNullOrWhiteSpace(siteOptions.Value.FeedUrl)) {
				writer.WriteStartElement("atom", "link", AtomNamespace);
				writer.WriteAttributeString("href", siteOptions.Value.FeedUrl);
				writer.WriteAttributeString("rel", "self");
				writer.WriteAttributeString("type", "application/rss+xml");
				writer.WriteEndElement();
			}

			if (!string.IsNullOrWhiteSpace(site?.Logo)
			    && Uri.TryCreate(siteUrl, site.Logo, out var logoUrl)
			    && (logoUrl.Scheme == Uri.UriSchemeHttps || logoUrl.Scheme == Uri.UriSchemeHttp)) {
				writer.WriteStartElement("image");
				writer.WriteElementString("url", logoUrl.AbsoluteUri);
				writer.WriteElementString("title", title);
				writer.WriteElementString("link", siteUrl.AbsoluteUri);
				writer.WriteEndElement();
			}

			foreach (var item in items) {
				var id = item.Id.ToString(CultureInfo.InvariantCulture);
				var articleUrl = new Uri(siteUrl, "/articles/" + id).AbsoluteUri;
				writer.WriteStartElement("item");
				writer.WriteElementString("title", item.Title);
				writer.WriteElementString("link", articleUrl);
				writer.WriteStartElement("guid");
				writer.WriteAttributeString("isPermaLink", "false");
				writer.WriteString("urn:mint-blog:article:" + id);
				writer.WriteEndElement();
				writer.WriteElementString("description", item.Summary);
				// No backend Markdown renderer: preserve the full source as safe, readable HTML.
				writer.WriteElementString("content", "encoded", ContentNamespace,
					"<pre>" + HtmlEncoder.Default.Encode(item.Content) + "</pre>");
				if (hasMail)
					writer.WriteElementString("author", string.IsNullOrWhiteSpace(author) ? mail : $"{mail} ({author})");
				else if (!string.IsNullOrWhiteSpace(author))
					writer.WriteElementString("dc", "creator", CreatorNamespace, author);
				writer.WriteElementString("pubDate", item.CreatedAt.UtcDateTime.ToString("R", CultureInfo.InvariantCulture));
				writer.WriteEndElement();
			}

			writer.WriteEndElement();
			writer.WriteEndElement();
			writer.WriteEndDocument();
		}

		return File(stream.ToArray(), "application/rss+xml; charset=utf-8");
	}
}
