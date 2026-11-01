using Mint.Blog.Common.Exceptions;
using Mint.Blog.Common.Constants;
using Mint.Blog.Model.Dtos.Blog.Tag;
using Mint.Blog.Model.Entitys.Blog.Resource;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Tag;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class TagService(ITagRepository repository, IResourceRepository resources, IUnitOfWork unitOfWork) : ITagService {
    public Task<IReadOnlyCollection<TagListItemDto>> GetAsync(CancellationToken cancellationToken = default) => repository.GetAsync(cancellationToken);
    public Task<PagedResult<TagListItemDto>> GetAsync(TagPageListQuery query, CancellationToken cancellationToken = default) => repository.GetAsync(query, cancellationToken);
    public async Task<long> CreateAsync(CreateTagCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.TagNameInvalid, "Tag name is required.");
        Guard.Against(command.CategoryId <= 0, ErrorCodes.CategoryNotFound, "必须选择有效分类。");
        var logo = NormalizeLogo(command.LogoUrl) ?? "";
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            Guard.Against(command.CategoryId <= 0 || !await resources.LockCategoryAsync(command.CategoryId, cancellationToken), ErrorCodes.CategoryNotFound, "分类不存在或已删除。");
            await CheckNameAsync(command.Name.Trim(), 0, cancellationToken);
            var id = await repository.AddAsync(command.Name.Trim(), command.CategoryId, logo, cancellationToken);
            var versionId = await resources.SaveVersionAsync(new TagVersion(0, id, "通用", 0, true), cancellationToken);
            Guard.Against(versionId <= 0, "general_version_missing", "创建通用版本失败。");
            await unitOfWork.CommitAsync(cancellationToken);
            return id;
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
    public async Task UpdateAsync(UpdateTagCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.TagNameInvalid, "Tag name is required.");
        Guard.Against(command.CategoryId <= 0, ErrorCodes.CategoryNotFound, "必须选择有效分类。");
        var logo = NormalizeLogo(command.LogoUrl);
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            var snapshot = await repository.GetSnapshotAsync(command.TagId, cancellationToken);
            Guard.Against(snapshot is null || snapshot.IsDeleted != 0, ErrorCodes.TagNotFound, "标签不存在或已删除。");
            foreach (var category in new[] { snapshot!.CategoryId, command.CategoryId }.Distinct().Order())
                Guard.Against(category <= 0 || !await resources.LockCategoryAsync(category, cancellationToken), ErrorCodes.CategoryNotFound, "分类不存在或已删除。");
            var current = await repository.LockCategorySnapshotAsync(command.TagId, cancellationToken);
            Guard.Against(current.Count != 1 || current.First() != snapshot.CategoryId, "tag_changed", "标签已改变，请刷新重试。");
            await CheckNameAsync(command.Name.Trim(), command.TagId, cancellationToken);
            await repository.UpdateAsync(command.TagId, command.Name.Trim(), command.CategoryId, logo, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
    public async Task UpdateSortAsync(UpdateTagSortCommand command, CancellationToken cancellationToken = default) {
        await RequireTagAsync(command.TagId, cancellationToken);
        await repository.UpdateSortAsync(command.TagId, command.Sort, cancellationToken);
    }
    public async Task MoveSortFirstAsync(MoveTagSortFirstCommand command, CancellationToken cancellationToken = default) {
        await RequireTagAsync(command.TagId, cancellationToken);
        await repository.MoveSortFirstAsync(command.TagId, cancellationToken);
    }
    public async Task MoveSortLastAsync(MoveTagSortLastCommand command, CancellationToken cancellationToken = default) {
        await RequireTagAsync(command.TagId, cancellationToken);
        await repository.MoveSortLastAsync(command.TagId, cancellationToken);
    }
    public async Task DeleteAsync(DeleteTagCommand command, CancellationToken cancellationToken = default) {
        Guard.Against(command.DeleteType is not 1 and not 2 and not 3, ErrorCodes.DeleteTypeInvalid, "Delete type is invalid.");
        await unitOfWork.BeginTransactionAsync(cancellationToken);
        try {
            Guard.Against(!await resources.LockTagAsync(command.TagId, cancellationToken, true), ErrorCodes.TagNotFound, "Tag does not exist.");
            if (command.DeleteType == 2 && await resources.TagHasNavigationDataAsync(command.TagId, cancellationToken))
                throw new BusinessException("tag_in_use", "标签存在版本、资源或文章版本数据（包括已删除数据），不能物理删除。请先处理关联数据或使用逻辑删除。");
            Guard.Against(command.DeleteType == 2, "tag_in_use", "标签的通用版本必须保留，请停用标签或关闭导航，不能物理删除。");
            Guard.Against(command.DeleteType is not (1 or 3), "delete_type_invalid", "删除操作无效。");
            if (command.DeleteType == 3)
                Guard.Against(!await repository.HasValidCategoryAsync(command.TagId, cancellationToken), ErrorCodes.CategoryNotFound, "分类已删除，不能恢复标签。");
            await repository.DeleteAsync(command.TagId, command.DeleteType, cancellationToken);
            await unitOfWork.CommitAsync(cancellationToken);
        } catch {
            await unitOfWork.RollbackAsync(CancellationToken.None);
            throw;
        }
    }
    private async Task RequireTagAsync(long id, CancellationToken ct) =>
        Guard.Against(!await repository.ExistsAsync(id, ct), ErrorCodes.TagNotFound, "Tag does not exist.");
    private async Task CheckNameAsync(string name, long excludingId, CancellationToken ct) =>
        Guard.Against(await repository.NameExistsAsync(name, excludingId, ct), "tag_name_conflict", "标签名已存在（包括已删除标签）。");
    private static string? NormalizeLogo(string? value) {
        var url = value?.Trim();
        if (string.IsNullOrEmpty(url)) return url;
        Guard.Against(url.Length > 2000 || !Uri.TryCreate(url, UriKind.Absolute, out var uri)
            || (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps)
            || !string.IsNullOrEmpty(uri.UserInfo), ErrorCodes.TagLogoInvalid,
            "标签Logo必须为不含用户名密码的HTTP/HTTPS绝对地址，且不超过2000字符。");
        return url;
    }
}
