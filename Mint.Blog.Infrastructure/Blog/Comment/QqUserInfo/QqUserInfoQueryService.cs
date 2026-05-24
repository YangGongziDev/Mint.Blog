using System.Net.Http.Json;
using Mint.Blog.Application.Blog.Comment.Queries.GetQqUserInfo;

namespace Mint.Blog.Infrastructure.Blog.Comment.QqUserInfo;

public sealed class QqUserInfoQueryService(HttpClient httpClient) : IGetQqUserInfoQueryService {
	public async Task<QqUserInfoDto?> GetAsync(GetQqUserInfoQuery query, CancellationToken cancellationToken = default){
		var url = $"https://api.qjqq.cn/api/qqinfo?qq={Uri.EscapeDataString(query.Qq)}";
		var response = await httpClient.GetFromJsonAsync<QqUserInfoResponse>(url, cancellationToken);

		if (response is null || response.Code != 200) return null;

		return new QqUserInfoDto(response.Avatar, response.Nickname, response.Mail);
	}
}