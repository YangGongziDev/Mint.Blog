using System.Net.Http.Json;
using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Model.Vos.Blog.Comment;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class QqUserInfoService(HttpClient httpClient) : IQqUserInfoService {
    public async Task<QqUserInfoDto?> GetAsync(GetQqUserInfoQuery query, CancellationToken cancellationToken = default) {
        var response = await httpClient.GetFromJsonAsync<QqUserInfoResponse>($"https://api.qjqq.cn/api/qqinfo?qq={Uri.EscapeDataString(query.Qq)}", cancellationToken);
        return response is null || response.Code != 200 ? null : new(response.Avatar, response.Nickname, response.Mail);
    }
}
