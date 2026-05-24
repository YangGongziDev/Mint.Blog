using System.Text.Json.Serialization;

namespace Mint.Blog.Infrastructure.Blog.Comment.QqUserInfo;

public sealed class QqUserInfoResponse {
	[JsonPropertyName("code")] public int Code { get; set; }

	[JsonPropertyName("imgurl")] public string Avatar { get; set; } = string.Empty;

	[JsonPropertyName("name")] public string Nickname { get; set; } = string.Empty;

	[JsonPropertyName("mail")] public string Mail { get; set; } = string.Empty;
}