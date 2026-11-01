using Mint.Blog.Common.Exceptions;
using Mint.Blog.Common.Constants;
using Mint.Blog.Model.Dtos.Blog.Resource;
using Mint.Blog.Model.Vos.Blog.Resource;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Entitys.Blog.Resource;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Service.IService.Blog;
using ResourceEntity = Mint.Blog.Model.Entitys.Blog.Resource.Resource;

namespace Mint.Blog.Service.Services.Blog;

public sealed class ResourceService(IResourceRepository repository, IUnitOfWork unitOfWork) : IResourceService {
    private static BusinessException Invalid(string message) => new("resource_invalid", message);
    private static BusinessException Missing(string message) => new("resource_not_found", message);
    private async Task<T> Transaction<T>(Func<Task<T>> action, CancellationToken ct){
        await unitOfWork.BeginTransactionAsync(ct);
        try {
            var result = await action();
            await unitOfWork.CommitAsync(ct);
            return result;
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
    public Task<long> ConfigureNavigationAsync(long tagId, ConfigureNavigationTagCommand command, CancellationToken ct){
        var description = command.NavigationDescription?.Trim() ?? "";
        if (description.Length > 500) throw Invalid("导航简介不能超过500字符。");
        return Transaction(async () => {
            await repository.LockTagsAsync([tagId], ct);
            await repository.UpdateNavigationAsync(tagId, command.ShowInNavigation, description, ct);
            return tagId;
        }, ct);
    }
    public Task<long> SaveVersionAsync(long tagId, long? versionId, SaveTagVersionCommand command, CancellationToken ct){
        var name = command.Name?.Trim() ?? "";
        if (name.Length is 0 or > 60) throw Invalid("版本名称长度应为1至60字符。");
        var targetTagId = command.TagId ?? tagId;
        if (!versionId.HasValue && targetTagId != tagId) throw Invalid("标签与路由不一致。");
        return Transaction(async () => {
            await repository.LockTagsAsync([tagId, targetTagId], ct);
            var version = versionId.HasValue
                ? await repository.GetVersionAsync(tagId, versionId.Value, true, ct) ?? throw Missing("版本不存在或已删除。")
                : new TagVersion(0, tagId, name, command.Sort, false);
            if (targetTagId != tagId && (version.IsGeneral || await repository.VersionReferencedAsync(version.Id, ct)))
                throw Invalid("通用版本或存在引用的版本不能更改所属标签。");
            if (await repository.VersionNameExistsAsync(targetTagId, name, version.Id, ct)) throw Invalid("版本名称已存在（包括已删除版本）。");
            version.MoveToTag(targetTagId);
            version.Update(name, command.Sort);
            return await repository.SaveVersionAsync(version, ct);
        }, ct);
    }
    public Task<long> DeleteVersionAsync(long tagId, long versionId, CancellationToken ct) => Transaction(async () => {
        await repository.LockTagsAsync([tagId], ct);
        var version = await repository.GetVersionAsync(tagId, versionId, true, ct) ?? throw Missing("版本不存在或已删除。");
        if (version.IsGeneral) throw Invalid("通用版本不能删除。");
        if (await repository.VersionReferencedAsync(versionId, ct))
            throw new BusinessException(ErrorCodes.TagVersionDeleteReferenced, "版本仍被资源、文章或草稿引用（包括已删除内容），不能删除。");
        version.Delete();
        await repository.SaveVersionAsync(version, ct);
        return versionId;
    }, ct);
    public Task<long> SaveResourceAsync(long? id, SaveResourceCommand command, CancellationToken ct){
        var title = command.Title?.Trim() ?? "";
        var url = command.Url?.Trim() ?? "";
        if (title.Length is 0 or > 200) throw Invalid("资源标题长度应为1至200字符。");
        if (url.Length > 2048 || !Uri.TryCreate(url, UriKind.Absolute, out var uri)
            || (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps)) throw Invalid("资源地址必须为HTTP/HTTPS地址，且不超过2048字符。");
        if (command.Kind is < 1 or > 4) throw Invalid("资源类型应为1至4。");
        if (command.TagId <= 0 || command.TagVersionId <= 0) throw Invalid("必须指定实际标签与版本ID。");
        return Transaction(async () => {
            var snapshot = id.HasValue ? await repository.GetResourceAsync(id.Value, false, ct, true) ?? throw Missing("资源不存在。") : null;
            await repository.LockTagsAsync([snapshot?.TagId ?? command.TagId, command.TagId], ct, true);
            await repository.LockTagsAsync([command.TagId], ct);
            if (await repository.GetVersionAsync(command.TagId, command.TagVersionId, true, ct) is null) throw Invalid("版本不存在、已删除或不属于该标签。");
            var resource = id.HasValue ? await repository.GetResourceAsync(id.Value, true, ct, true) ?? throw Missing("资源不存在。")
                : new ResourceEntity(0, command.TagId, command.TagVersionId, title, command.Description?.Trim() ?? "", url, command.Kind, command.IsFeatured, command.Sort);
            if (snapshot is not null) EnsureUnchanged(snapshot, resource);
            if (await repository.ResourceUrlExistsAsync(command.TagId, command.TagVersionId, url, resource.Id, ct)) throw Invalid("该标签和版本下资源地址已存在（包括已删除资源），请恢复或编辑原记录。");
            resource.Update(command.TagId, command.TagVersionId, title, command.Description?.Trim() ?? "", url, command.Kind, command.IsFeatured, command.Sort);
            return await repository.SaveResourceAsync(resource, ct);
        }, ct);
    }
    public Task<long> DeleteResourceAsync(long id, CancellationToken ct) => Transaction(async () => {
        var snapshot = await repository.GetResourceAsync(id, false, ct) ?? throw Missing("资源不存在或已删除。");
        await repository.LockTagsAsync([snapshot.TagId], ct, true);
        var resource = await repository.GetResourceAsync(id, true, ct) ?? throw Missing("资源不存在或已删除。");
        EnsureUnchanged(snapshot, resource);
        resource.Delete();
        await repository.SaveResourceAsync(resource, ct);
        return id;
    }, ct);
    public Task<long> RestoreResourceAsync(long id, CancellationToken ct) => Transaction(async () => {
        var snapshot = await repository.GetResourceAsync(id, false, ct, true) ?? throw Missing("资源不存在。");
        await repository.LockTagsAsync([snapshot.TagId], ct);
        if (await repository.GetVersionAsync(snapshot.TagId, snapshot.TagVersionId, true, ct) is null)
            throw Invalid("版本不存在、已删除或不属于该标签，请先编辑资源选择。");
        var resource = await repository.GetResourceAsync(id, true, ct, true) ?? throw Missing("资源不存在。");
        EnsureUnchanged(snapshot, resource);
        if (await repository.ResourceUrlExistsAsync(resource.TagId, resource.TagVersionId, resource.Url, id, ct))
            throw Invalid("该标签和版本下资源地址已存在，请先编辑原记录。");
        resource.Restore();
        return await repository.SaveResourceAsync(resource, ct);
    }, ct);
    private static void EnsureUnchanged(ResourceEntity snapshot, ResourceEntity resource){
        if (snapshot.TagId != resource.TagId || snapshot.TagVersionId != resource.TagVersionId || snapshot.IsDeleted != resource.IsDeleted)
            throw Invalid("资源已被并发修改，请刷新后重试。");
    }
    public async Task<PagedResult<NavigationArticleDto>> GetArticlesAsync(long tagId, NavigationArticleQuery query, CancellationToken ct){
        await RequireTag(tagId, true, ct);
        if (query.TagVersionId is not > 0 || !await repository.VersionAvailableAsync(tagId, query.TagVersionId.Value, ct))
            throw Invalid("必须指定属于当前标签的有效版本。");
        return await repository.GetArticlesAsync(tagId, query with { PageNumber = Math.Max(1, query.PageNumber), PageSize = Math.Clamp(query.PageSize, 1, 100) }, ct);
    }
    public Task<IReadOnlyCollection<NavigationTagDto>> GetNavigationTagsAsync(bool publicOnly, long? categoryId, string? keyword, CancellationToken ct) => repository.GetNavigationTagsAsync(publicOnly, categoryId, keyword, ct);
    public async Task<IReadOnlyCollection<TagVersionDto>> GetVersionsAsync(long tagId, bool publicOnly, CancellationToken ct){
        await RequireTag(tagId, publicOnly, ct);
        return await repository.GetVersionsAsync(tagId, ct);
    }
    private async Task RequireTag(long tagId, bool publicOnly, CancellationToken ct){
        if (tagId <= 0 || !await repository.TagAvailableAsync(tagId, publicOnly, ct)) throw new BusinessException("tag_not_found", "标签不存在或不可用。");
    }
    public async Task<PagedResult<ResourceDto>> GetResourcesAsync(ResourcePageQuery query, bool publicOnly, CancellationToken ct){
        if (publicOnly && (query.TagId is not > 0 || query.TagVersionId is not > 0)) throw Invalid("必须指定标签和实际版本ID。");
        if (query.Kind.HasValue && query.Kind is < 1 or > 4) throw Invalid("资源类型应为1至4。");
        if (query.TagId is <= 0 || query.TagVersionId is <= 0 || (query.TagVersionId.HasValue && !query.TagId.HasValue))
            throw Invalid("版本筛选必须指定标签及实际版本ID。");
        if (publicOnly) {
            await RequireTag(query.TagId!.Value, true, ct);
            if (!await repository.VersionAvailableAsync(query.TagId.Value, query.TagVersionId!.Value, ct))
                throw Invalid("版本不存在、已删除或不属于该标签。");
        }
        return await repository.GetResourcesAsync(query with { PageNumber = Math.Max(1, query.PageNumber), PageSize = Math.Clamp(query.PageSize, 1, 100) }, publicOnly, ct);
    }
    public async Task<ResourceDto> GetResourceAsync(long id, CancellationToken ct) => await repository.GetResourceAsync(id, ct) ?? throw Missing("资源不存在。");
}
