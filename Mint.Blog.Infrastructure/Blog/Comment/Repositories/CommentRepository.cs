using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Comment.Queries.GetAdminCommentPageList;
using Mint.Blog.Application.Blog.Comment.Queries.GetCommentList;
using Mint.Blog.Domain.Blog.Comment.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Comment.Persistence;
using CommentEntity = Mint.Blog.Domain.Blog.Comment.Entities.Comment;

namespace Mint.Blog.Infrastructure.Blog.Comment.Repositories;

public sealed class CommentRepository(ISqlSugarDbContext dbContext)
	: ICommentRepository, IGetCommentListQueryService, IGetAdminCommentPageListQueryService {
	private const int NormalStatus = 2;

	public async Task<long> AddAsync(CommentEntity comment, CancellationToken cancellationToken = default){
		var data = new CommentDataModel {
			Content = comment.Content.Value,
			Avatar = comment.Avatar,
			Nickname = comment.Nickname.Value,
			Mail = comment.Mail.Value,
			Website = comment.Website.Value,
			RouterUrl = comment.RouterUrl,
			CreatedAt = comment.CreatedAt,
			UpdatedAt = comment.UpdatedAt,
			IsDeleted = comment.IsDeleted ? (short)1 : (short)0,
			ReplyCommentId = comment.ReplyCommentId,
			ParentCommentId = comment.ParentCommentId,
			Status = comment.Status,
			Reason = comment.Reason
		};

		return await dbContext.Client.Insertable(data).ExecuteReturnSnowflakeIdAsync();
	}

	public async Task<CommentEntity?> GetByIdAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<CommentDataModel>()
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task<CommentEntity?> GetByIdIncludingDeletedAsync(long id, CancellationToken cancellationToken = default){
		var data = await dbContext.Client.Queryable<CommentDataModel>()
			.Where(x => x.Id == id)
			.SingleAsync();

		return data is null ? null : MapToDomain(data);
	}

	public async Task<IReadOnlyCollection<CommentEntity>> GetByRouterUrlAndStatusAsync(string routerUrl, int status,
		CancellationToken cancellationToken = default){
		var items = await dbContext.Client.Queryable<CommentDataModel>()
			.Where(x => x.RouterUrl == routerUrl && x.Status == status && x.IsDeleted == 0)
			.OrderByDescending(x => x.CreatedAt)
			.ToListAsync();

		return items.Select(MapToDomain).ToArray();
	}

	public async Task<IReadOnlyCollection<CommentEntity>> GetAllAsync(CancellationToken cancellationToken = default){
		var items = await dbContext.Client.Queryable<CommentDataModel>()
			.Where(x => x.IsDeleted == 0)
			.OrderByDescending(x => x.CreatedAt)
			.ToListAsync();

		return items.Select(MapToDomain).ToArray();
	}

	public Task UpdateAsync(CommentEntity comment, CancellationToken cancellationToken = default){
		var data = new CommentDataModel {
			Id = comment.Id,
			Content = comment.Content.Value,
			Avatar = comment.Avatar,
			Nickname = comment.Nickname.Value,
			Mail = comment.Mail.Value,
			Website = comment.Website.Value,
			RouterUrl = comment.RouterUrl,
			CreatedAt = comment.CreatedAt,
			UpdatedAt = comment.UpdatedAt,
			IsDeleted = comment.IsDeleted ? (short)1 : (short)0,
			ReplyCommentId = comment.ReplyCommentId,
			ParentCommentId = comment.ParentCommentId,
			Status = comment.Status,
			Reason = comment.Reason
		};

		return dbContext.Client.Updateable(data).ExecuteCommandAsync();
	}

	public async Task DeleteAsync(long id, CancellationToken cancellationToken = default){
		var comment = await dbContext.Client.Queryable<CommentDataModel>()
			.Where(x => x.Id == id && x.IsDeleted == 0)
			.SingleAsync();

		if (comment is null) return;

		comment.IsDeleted = 1;
		comment.UpdatedAt = DateTimeOffset.UtcNow;
		await dbContext.Client.Updateable(comment).ExecuteCommandAsync();
	}

	public async Task<PagedResult<AdminCommentPageItemDto>> GetAsync(GetAdminCommentPageListQuery query,
		CancellationToken cancellationToken = default){
		var pageNumber = query.PageNumber <= 0 ? 1 : query.PageNumber;
		var pageSize = query.PageSize <= 0 ? 10 : query.PageSize;
		var skip = (pageNumber - 1) * pageSize;

		var commentQueryable = dbContext.Client.Queryable<CommentDataModel>()
			.Where(x => x.IsDeleted == 0);

		if (!string.IsNullOrWhiteSpace(query.RouterUrl))
			commentQueryable = commentQueryable.Where(x => x.RouterUrl.Contains(query.RouterUrl));

		if (query.Status.HasValue) commentQueryable = commentQueryable.Where(x => x.Status == query.Status.Value);

		if (query.StartDate.HasValue) {
			var start = query.StartDate.Value.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc);
			commentQueryable = commentQueryable.Where(x => x.CreatedAt >= start);
		}

		if (query.EndDate.HasValue) {
			var end = query.EndDate.Value.ToDateTime(TimeOnly.MaxValue, DateTimeKind.Utc);
			commentQueryable = commentQueryable.Where(x => x.CreatedAt <= end);
		}

		var totalCount = await commentQueryable.CountAsync();
		var orderedCommentQueryable = string.Equals(query.SortOrder, "timeAsc", StringComparison.OrdinalIgnoreCase)
			? commentQueryable.OrderBy(x => x.CreatedAt)
			: commentQueryable.OrderByDescending(x => x.CreatedAt);

		var comments = await orderedCommentQueryable
			.Skip(skip)
			.Take(pageSize)
			.ToListAsync();

		var items = comments
			.Select(comment => new AdminCommentPageItemDto(
				comment.Id,
				comment.RouterUrl,
				comment.Avatar,
				comment.Nickname,
				comment.Mail,
				comment.Website,
				comment.CreatedAt,
				comment.Content,
				comment.Status,
				comment.Reason,
				comment.IsDeleted != 0))
			.ToArray();

		return new PagedResult<AdminCommentPageItemDto>(items, pageNumber, pageSize, totalCount);
	}

	public async Task<CommentListDto>
		GetAsync(GetCommentListQuery query, CancellationToken cancellationToken = default){
		var comments = await GetByRouterUrlAndStatusAsync(query.RouterUrl, NormalStatus, cancellationToken);
		var total = comments.Count;

		if (total == 0) return new CommentListDto(0, null);

		var topLevelComments = comments
			.Where(comment => comment.ParentCommentId is null)
			.OrderByDescending(comment => comment.CreatedAt)
			.ToArray();

		var items = topLevelComments
			.Select(comment => MapToDto(comment, comments))
			.ToArray();

		return new CommentListDto(total, items);
	}

	private static CommentItemDto MapToDto(CommentEntity comment, IReadOnlyCollection<CommentEntity> allComments){
		var childComments = allComments
			.Where(item => item.ParentCommentId == comment.Id)
			.OrderBy(item => item.CreatedAt)
			.Select(item => {
				string? replyNickname = null;
				if (item.ReplyCommentId != comment.Id)
					replyNickname = allComments.FirstOrDefault(candidate => candidate.Id == item.ReplyCommentId)
						?.Nickname.Value;

				return new CommentItemDto(
					item.Id,
					item.Avatar,
					item.Nickname.Value,
					item.Website.Value,
					item.Content.Value,
					item.CreatedAt,
					replyNickname,
					[],
					false);
			})
			.ToArray();

		return new CommentItemDto(
			comment.Id,
			comment.Avatar,
			comment.Nickname.Value,
			comment.Website.Value,
			comment.Content.Value,
			comment.CreatedAt,
			null,
			childComments,
			false);
	}

	private static CommentEntity MapToDomain(CommentDataModel data){
		return CommentEntity.Rehydrate(
			data.Id,
			data.Content,
			data.Avatar,
			data.Nickname,
			data.Mail,
			data.Website,
			data.RouterUrl,
			data.IsDeleted != 0,
			data.ReplyCommentId,
			data.ParentCommentId,
			data.Status,
			data.Reason,
			data.CreatedAt,
			data.UpdatedAt);
	}
}
