using Mint.Blog.Model.Dtos.Blog.Comment;
using Mint.Blog.Model.Entitys.Blog.Comment;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.Persistence;

namespace Mint.Blog.Repository.Repositorys.Blog;

public sealed class CommentRepository(ISqlSugarDbContext dbContext) : ICommentRepository {
    public Task<long> AddAsync(CommentDataModel comment, CancellationToken cancellationToken = default) => dbContext.Client.Insertable(comment).ExecuteReturnSnowflakeIdAsync();
    public async Task<CommentDataModel?> GetAsync(long id, bool includingDeleted = false, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<CommentDataModel>().Where(x => x.Id == id).WhereIF(!includingDeleted, x => x.IsDeleted == 0).SingleAsync();
    public async Task<IReadOnlyCollection<CommentDataModel>> GetAllAsync(CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<CommentDataModel>().Where(x => x.IsDeleted == 0).OrderByDescending(x => x.CreatedAt).ToListAsync();
    public async Task<IReadOnlyCollection<CommentDataModel>> GetNormalAsync(string routerUrl, CancellationToken cancellationToken = default) =>
        await dbContext.Client.Queryable<CommentDataModel>().Where(x => x.RouterUrl == routerUrl && x.Status == 2 && x.IsDeleted == 0).OrderByDescending(x => x.CreatedAt).ToListAsync();
    public Task UpdateAsync(CommentDataModel comment, CancellationToken cancellationToken = default) => dbContext.Client.Updateable(comment).ExecuteCommandAsync();
    public async Task<(IReadOnlyCollection<CommentDataModel> Items, int Total)> GetPageAsync(GetAdminCommentPageListQuery query, DateTime? start, DateTime? end, CancellationToken cancellationToken = default) {
        var rows = dbContext.Client.Queryable<CommentDataModel>().Where(x => x.IsDeleted == 0);
        if (!string.IsNullOrWhiteSpace(query.RouterUrl)) rows = rows.Where(x => x.RouterUrl.Contains(query.RouterUrl));
        if (query.Status.HasValue) rows = rows.Where(x => x.Status == query.Status.Value);
        if (start.HasValue) rows = rows.Where(x => x.CreatedAt >= start.Value);
        if (end.HasValue) rows = rows.Where(x => x.CreatedAt <= end.Value);
        var total = await rows.CountAsync();
        rows = string.Equals(query.SortOrder, "timeAsc", StringComparison.OrdinalIgnoreCase) ? rows.OrderBy(x => x.CreatedAt) : rows.OrderByDescending(x => x.CreatedAt);
        return (await rows.Skip((query.PageNumber - 1) * query.PageSize).Take(query.PageSize).ToListAsync(), total);
    }
}
