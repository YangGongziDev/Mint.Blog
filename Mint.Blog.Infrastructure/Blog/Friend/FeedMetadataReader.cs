using System.Net;
using System.Net.Sockets;
using System.Xml;
using System.Xml.Linq;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using Mint.Blog.Application.Blog.Friend;
using Mint.Blog.Infrastructure.Options;

namespace Mint.Blog.Infrastructure.Blog.Friend;

public sealed class FeedMetadataReader(IOptions<SiteOptions> siteOptions, IHostEnvironment environment) : IFeedMetadataReader {
	private const int MaxBytes = 1024 * 1024;

	public async Task<FeedMetadata> ReadAsync(string url, CancellationToken cancellationToken = default){
		var trustedLocalFeed = environment.IsDevelopment() &&
			Uri.TryCreate(siteOptions.Value.FeedUrl, UriKind.Absolute, out var feedUri) && feedUri.IsLoopback
				? feedUri : null;
		if (url.Length > 2048 || !Uri.TryCreate(url, UriKind.Absolute, out var uri))
			throw new InvalidDataException("请输入有效的订阅链接");

		using var timeout = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
		timeout.CancelAfter(TimeSpan.FromSeconds(10));
		using var handler = new SocketsHttpHandler {
			AllowAutoRedirect = false,
			UseProxy = false,
			UseCookies = false,
			PooledConnectionLifetime = trustedLocalFeed is null ? Timeout.InfiniteTimeSpan : TimeSpan.Zero,
			MaxResponseHeadersLength = 16,
			ConnectCallback = async (context, token) => {
				var addresses = await Dns.GetHostAddressesAsync(context.DnsEndPoint.Host, token);
				var isTrustedLocalFeed = IsTrustedLocalFeed(context.InitialRequestMessage.RequestUri!, trustedLocalFeed);
				if (addresses.Length == 0 || addresses.Any(address => isTrustedLocalFeed
					    ? !IPAddress.IsLoopback(address.IsIPv4MappedToIPv6 ? address.MapToIPv4() : address)
					    : !IsPublicAddress(address)))
					throw new InvalidDataException("订阅链接必须指向公网地址");
				var socket = new Socket(SocketType.Stream, ProtocolType.Tcp);
				try {
					// Connect only to the validated addresses, never resolve the hostname again.
					await socket.ConnectAsync(addresses, context.DnsEndPoint.Port, token);
					return new NetworkStream(socket, ownsSocket: true);
				}
				catch {
					socket.Dispose();
					throw;
				}
			}
		};
		using var client = new HttpClient(handler);
		client.DefaultRequestHeaders.UserAgent.ParseAdd("MintBlog-FeedMetadata/1.0");
		for (var redirect = 0; redirect <= 3; redirect++) {
			ValidateUri(uri, trustedLocalFeed);
			using var response = await client.GetAsync(uri, HttpCompletionOption.ResponseHeadersRead, timeout.Token);
			if ((int)response.StatusCode is 301 or 302 or 303 or 307 or 308) {
				if (redirect == 3 || response.Headers.Location is not { } location)
					throw new InvalidDataException("订阅源重定向过多或无效");
				uri = new Uri(uri, location);
				continue;
			}
			response.EnsureSuccessStatusCode();
			if (response.Content.Headers.ContentLength > MaxBytes)
				throw new InvalidDataException("订阅源不能超过 1 MB");
			await using var stream = await response.Content.ReadAsStreamAsync(timeout.Token);
			using var content = new MemoryStream();
			var buffer = new byte[8192];
			int count;
			while ((count = await stream.ReadAsync(buffer, timeout.Token)) != 0) {
				if (content.Length + count > MaxBytes)
					throw new InvalidDataException("订阅源不能超过 1 MB");
				content.Write(buffer, 0, count);
			}
			content.Position = 0;
			using var reader = XmlReader.Create(content, new XmlReaderSettings {
				DtdProcessing = DtdProcessing.Prohibit,
				XmlResolver = null,
				MaxCharactersInDocument = MaxBytes
			});
			return Parse(XDocument.Load(reader), uri);
		}
		throw new InvalidDataException("无效订阅源");
	}

	private static bool IsTrustedLocalFeed(Uri uri, Uri? trustedLocalFeed) =>
		trustedLocalFeed is { IsAbsoluteUri: true, IsLoopback: true } &&
		uri.Scheme is "http" or "https" && string.IsNullOrEmpty(uri.UserInfo) &&
		string.IsNullOrEmpty(uri.Fragment) && string.IsNullOrEmpty(trustedLocalFeed.UserInfo) &&
		string.IsNullOrEmpty(trustedLocalFeed.Fragment) &&
		string.Equals(uri.Scheme, trustedLocalFeed.Scheme, StringComparison.OrdinalIgnoreCase) &&
		string.Equals(uri.IdnHost, trustedLocalFeed.IdnHost, StringComparison.OrdinalIgnoreCase) &&
		uri.Port == trustedLocalFeed.Port &&
		string.Equals(uri.AbsolutePath, trustedLocalFeed.AbsolutePath, StringComparison.Ordinal) &&
		string.Equals(uri.Query, trustedLocalFeed.Query, StringComparison.Ordinal);

	private static void ValidateUri(Uri uri, Uri? trustedLocalFeed){
		if (IsTrustedLocalFeed(uri, trustedLocalFeed)) return;
		if (uri.Scheme is not ("http" or "https") || !string.IsNullOrEmpty(uri.UserInfo) || !uri.IsDefaultPort)
			throw new InvalidDataException("仅支持标准端口的 HTTP/HTTPS 公网订阅链接");
		if (IPAddress.TryParse(uri.IdnHost.Trim('[', ']'), out var address) && !IsPublicAddress(address))
			throw new InvalidDataException("订阅链接必须指向公网地址");
	}

	internal static bool IsPublicAddress(IPAddress address){
		if (address.IsIPv4MappedToIPv6) address = address.MapToIPv4();
		var bytes = address.GetAddressBytes();
		if (address.AddressFamily == AddressFamily.InterNetwork) {
			return bytes[0] is not (0 or 10 or 127) && bytes[0] < 224 &&
				!(bytes[0] == 100 && bytes[1] is >= 64 and <= 127) &&
				!(bytes[0] == 169 && bytes[1] == 254) &&
				!(bytes[0] == 172 && bytes[1] is >= 16 and <= 31) &&
				!(bytes[0] == 192 && (bytes[1] is 0 or 168 || bytes[1] == 2)) &&
				!(bytes[0] == 198 && (bytes[1] is 18 or 19 || bytes[1] == 51 && bytes[2] == 100)) &&
				!(bytes[0] == 203 && bytes[1] == 0 && bytes[2] == 113);
		}
		// Only native global unicast; exclude special-use and transition ranges.
		return address.AddressFamily == AddressFamily.InterNetworkV6 && address.ScopeId == 0 &&
			(bytes[0] & 0xe0) == 0x20 &&
			!(bytes[0] == 0x20 && bytes[1] == 0x01 && (bytes[2] < 2 || bytes[2] == 0x0d && bytes[3] == 0xb8)) &&
			!(bytes[0] == 0x20 && bytes[1] == 0x02) &&
			!(bytes[0] == 0x3f && bytes[1] == 0xff && bytes[2] < 0x10);
	}

	internal static FeedMetadata Parse(XDocument document, Uri source){
		var root = document.Root ?? throw new InvalidDataException("无效订阅源");
		XNamespace atom = "http://www.w3.org/2005/Atom";
		XElement? channel;
		string? link;
		XElement? icon;
		if (root.Name == atom + "feed") {
			channel = root;
			link = (string?)root.Elements(atom + "link")
				.FirstOrDefault(element => (string?)element.Attribute("rel") is null or "alternate")?.Attribute("href");
			icon = root.Element(atom + "icon") ?? root.Element(atom + "logo");
		}
		else if (root.Name.LocalName is "rss" or "RDF" &&
			(channel = root.Elements().FirstOrDefault(element => element.Name.LocalName == "channel")) is not null) {
			link = channel.Elements().FirstOrDefault(element => element.Name.LocalName == "link" && !element.HasAttributes)?.Value;
			var image = channel.Elements().FirstOrDefault(element => element.Name.LocalName == "image");
			icon = image?.Elements().FirstOrDefault(element => element.Name.LocalName == "url");
		}
		else {
			throw new InvalidDataException("链接内容不是 RSS 或 Atom 订阅源");
		}
		string? Text(string name, int limit){
			var text = channel.Elements().FirstOrDefault(element => element.Name.LocalName == name)?.Value.Trim();
			return string.IsNullOrWhiteSpace(text) ? null : text[..Math.Min(text.Length, limit)];
		}
		return new FeedMetadata(Text("title", 200), ResolveLink(link, channel, source),
			Text(root.Name == atom + "feed" ? "subtitle" : "description", 200), ResolveLink(icon?.Value, icon, source));
	}

	private static string? ResolveLink(string? value, XElement? element, Uri source){
		if (string.IsNullOrWhiteSpace(value)) return null;
		foreach (var ancestor in element?.AncestorsAndSelf().Reverse() ?? []) {
			var xmlBase = (string?)ancestor.Attribute(XNamespace.Xml + "base");
			if (xmlBase is not null && Uri.TryCreate(source, xmlBase, out var basis)) source = basis;
		}
		if (!Uri.TryCreate(source, value.Trim(), out var uri) || uri.Scheme is not ("http" or "https") ||
			!string.IsNullOrEmpty(uri.UserInfo)) return null;
		return uri.AbsoluteUri;
	}
}
