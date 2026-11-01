using Mint.Blog.Common.Exceptions;
using Mint.Blog.Repository.IRepository.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class ArticleTagVersionService(IResourceRepository resources) {
    public async Task ValidateAsync(long? tagId, long? tagVersionId, bool draft, CancellationToken ct) {
        if (draft && tagId is null && tagVersionId is null) return;
        Guard.Against(tagId is not > 0 || tagVersionId is not > 0, "article_tag_version_invalid", "必须同时选择标签和实际版本ID；草稿可同时为空。");
        await resources.LockTagsAsync([tagId!.Value], ct);
        Guard.Against(await resources.GetVersionAsync(tagId.Value, tagVersionId!.Value, true, ct) is null,
            "article_tag_version_invalid", "版本不存在、已删除或不属于该标签。");
    }
}
