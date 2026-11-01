using System.Net.Mail;
using System.Xml;
using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Friend;
using Mint.Blog.Model.Entitys.Blog.Friend;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Friend;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class FriendService(IFriendRepository repository, IFeedMetadataReader feedMetadataReader,
	IFriendApplicationEvents events) : IFriendService {
	public Task<FeedMetadata> ReadAsync(string url, CancellationToken cancellationToken = default) => feedMetadataReader.ReadAsync(url, cancellationToken);

	public async Task<long> ApplyAsync(ApplyFriendCommand command, CancellationToken cancellationToken = default){
		var friend = Create(command.Name, command.Avatar, command.Category, command.Url, command.Description, command.Email, command.RssUrl, "pending");
		var id = await repository.AddAsync(friend, cancellationToken);
		await events.AppliedAsync(0, friend.CreatedAt, cancellationToken);
		return id;
	}

	public Task<long> CreateAsync(CreateAdminFriendCommand command, CancellationToken cancellationToken = default) =>
		repository.AddAsync(Create(command.Name, command.Avatar, command.Category, command.Url, command.Description, command.Email, command.RssUrl, "active"), cancellationToken);

	private static FriendDataModel Create(string name, string avatar, string category, string url, string description, string? email, string? rssUrl, string status){
		var friend = new FriendDataModel();
		SetProfile(friend, name, avatar, category, url, description, email, rssUrl);
		var now = DateTimeOffset.UtcNow;
		friend.Status = status;
		friend.CreatedAt = now;
		friend.UpdatedAt = now;
		return friend;
	}

	private static void SetProfile(FriendDataModel friend, string name, string avatar, string category, string url, string description, string? email, string? rssUrl){
		Guard.Against(string.IsNullOrWhiteSpace(name), ErrorCodes.FriendNameInvalid, "Friend name is required.");
		Guard.Against(string.IsNullOrWhiteSpace(avatar), ErrorCodes.FriendAvatarInvalid, "Friend avatar is required.");
		Guard.Against(string.IsNullOrWhiteSpace(category), ErrorCodes.FriendCategoryInvalid, "Friend category is required.");
		Guard.Against(string.IsNullOrWhiteSpace(url), ErrorCodes.FriendUrlInvalid, "Friend url is required.");
		Guard.Against(string.IsNullOrWhiteSpace(description), ErrorCodes.FriendDescriptionInvalid, "Friend description is required.");
		var normalizedUrl = url.Trim();
		Guard.Against(!Uri.TryCreate(normalizedUrl, UriKind.Absolute, out _), ErrorCodes.FriendUrlInvalid, "Friend url is invalid.");
		var normalizedEmail = string.IsNullOrWhiteSpace(email) ? string.Empty : email.Trim();
		Guard.Against(normalizedEmail.Length > 0 && !MailAddress.TryCreate(normalizedEmail, out _), ErrorCodes.FriendEmailInvalid, "Friend email is invalid.");
		var normalizedRssUrl = string.IsNullOrWhiteSpace(rssUrl) ? null : rssUrl.Trim();
		if (normalizedRssUrl is not null) {
			Guard.Against(normalizedRssUrl.Length > 1000, ErrorCodes.FriendRssUrlInvalid, "Friend RSS url cannot exceed 1000 characters.");
			Guard.Against(!Uri.TryCreate(normalizedRssUrl, UriKind.Absolute, out var uri) || (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps), ErrorCodes.FriendRssUrlInvalid, "Friend RSS url must be an HTTP/HTTPS url.");
		}
		friend.Name = name.Trim();
		friend.Avatar = avatar.Trim();
		friend.Category = category.Trim();
		friend.Url = normalizedUrl;
		friend.Email = normalizedEmail;
		friend.RssUrl = normalizedRssUrl;
		friend.Description = description.Trim();
		friend.UpdatedAt = DateTimeOffset.UtcNow;
	}

	private async Task<FriendDataModel> RequireAsync(long id, bool includingDeleted, CancellationToken cancellationToken){
		var friend = await repository.GetByIdAsync(id, includingDeleted, cancellationToken);
		Guard.Against(friend is null, ErrorCodes.FriendNotFound, "Friend does not exist.");
		// Preserve the original domain rehydration validation before any mutation.
		if (string.IsNullOrWhiteSpace(friend!.Url))
			throw new ArgumentException("Website url is required.", "value");
		if (!Uri.TryCreate(friend.Url.Trim(), UriKind.Absolute, out _))
			throw new ArgumentException("Website url format is invalid.", "value");
		if (!string.IsNullOrWhiteSpace(friend.Email) && !MailAddress.TryCreate(friend.Email.Trim(), out _))
			throw new ArgumentException("Email address format is invalid.", "value");
		friend.Url = friend.Url.Trim();
		friend.Email = string.IsNullOrWhiteSpace(friend.Email) ? string.Empty : friend.Email.Trim();
		friend.RssUrl = string.IsNullOrWhiteSpace(friend.RssUrl) ? null : friend.RssUrl.Trim();
		friend.IsDeleted = friend.IsDeleted != 0 ? (short)1 : (short)0;
		return friend;
	}

	public async Task UpdateAsync(UpdateFriendCommand command, CancellationToken cancellationToken = default){
		var friend = await RequireAsync(command.FriendId, false, cancellationToken);
		SetProfile(friend, command.Name, command.Avatar, command.Category, command.Url, command.Description, command.Email, command.RssUrl);
		await repository.UpdateAsync(friend, cancellationToken);
	}

	public async Task DeleteAsync(DeleteFriendCommand command, CancellationToken cancellationToken = default){
		Guard.Against(command.DeleteType is not 1 and not 2 and not 3, ErrorCodes.DeleteTypeInvalid, "Delete type is invalid.");
		var friend = await RequireAsync(command.FriendId, true, cancellationToken);
		if (command.DeleteType == 2) {
			await repository.DeleteAsync(command.FriendId, cancellationToken);
			return;
		}
		var deleted = command.DeleteType == 1 ? (short)1 : (short)0;
		if (friend.IsDeleted != deleted) {
			friend.IsDeleted = deleted;
			friend.UpdatedAt = DateTimeOffset.UtcNow;
		}
		await repository.UpdateAsync(friend, cancellationToken);
	}

	public async Task SetTopAsync(SetFriendTopCommand command, CancellationToken cancellationToken = default){
		var friend = await RequireAsync(command.FriendId, false, cancellationToken);
		if (friend.IsTop != command.IsTop) {
			friend.IsTop = command.IsTop;
			friend.UpdatedAt = DateTimeOffset.UtcNow;
		}
		await repository.UpdateAsync(friend, cancellationToken);
	}

	public async Task SetStatusAsync(SetFriendStatusCommand command, CancellationToken cancellationToken = default){
		var friend = await RequireAsync(command.FriendId, false, cancellationToken);
		var status = command.Status?.Trim().ToLowerInvariant();
		Guard.Against(status is not "active" and not "inactive" and not "pending", ErrorCodes.FriendStatusInvalid, "Friend status is invalid.");
		if (friend.Status != status) {
			friend.Status = status!;
			friend.UpdatedAt = DateTimeOffset.UtcNow;
		}
		await repository.UpdateAsync(friend, cancellationToken);
	}

	public async Task UpdateSortAsync(UpdateFriendSortCommand command, CancellationToken cancellationToken = default){
		var friend = await RequireAsync(command.FriendId, false, cancellationToken);
		friend.Sort = command.Sort;
		friend.UpdatedAt = DateTimeOffset.UtcNow;
		await repository.UpdateAsync(friend, cancellationToken);
	}

	public async Task MoveSortFirstAsync(MoveFriendSortFirstCommand command, CancellationToken cancellationToken = default){
		var friend = await RequireAsync(command.FriendId, false, cancellationToken);
		friend.Sort = Math.Max(0, await repository.GetMaxSortAsync(cancellationToken)) + 1;
		friend.UpdatedAt = DateTimeOffset.UtcNow;
		await repository.UpdateAsync(friend, cancellationToken);
	}

	public async Task MoveSortLastAsync(MoveFriendSortLastCommand command, CancellationToken cancellationToken = default){
		var friend = await RequireAsync(command.FriendId, false, cancellationToken);
		var min = await repository.GetMinSortAsync(cancellationToken);
		friend.Sort = min is null ? 0 : Math.Max(0, min.Value - 1);
		friend.UpdatedAt = DateTimeOffset.UtcNow;
		await repository.UpdateAsync(friend, cancellationToken);
	}

	public async Task<FriendDetailVo?> GetAsync(GetFriendDetailQuery query, CancellationToken cancellationToken = default){
		var x = await repository.GetByIdAsync(query.FriendId, false, cancellationToken);
		return x is null ? null : new(x.Id, x.Name, x.Description, x.Url, x.Avatar, x.Status, x.CreatedAt, x.Category, x.IsTop, x.Email, x.Sort, x.UpdatedAt);
	}

	public async Task<PagedResult<AdminFriendPageItemVo>> GetAsync(GetAdminFriendPageListQuery query, CancellationToken cancellationToken = default){
		var page = await repository.GetAsync(query, cancellationToken);
		return new(page.Items.Select(x => new AdminFriendPageItemVo(x.Id, x.Name, x.Description, x.Url, x.Avatar, x.Status, x.CreatedAt, x.Category, x.IsTop, x.Email, x.Sort, x.IsDeleted != 0, x.UpdatedAt, x.RssUrl)).ToArray(), page.PageNumber, page.PageSize, page.TotalCount);
	}

	public async Task<PagedResult<FriendListItemVo>> GetAsync(GetFriendListQuery query, CancellationToken cancellationToken = default){
		var page = await repository.GetAsync(query, cancellationToken);
		var friends = page.Items.ToArray();
		var items = friends.Select(x => new FriendListItemVo(x.Id, x.Name, x.Description, x.Url, x.Avatar, x.Status, x.CreatedAt, x.Category, x.IsTop, x.Email, x.Sort, x.UpdatedAt)).ToArray();
		using var budget = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
		budget.CancelAfter(TimeSpan.FromSeconds(8));
		try {
			await Parallel.ForEachAsync(Enumerable.Range(0, friends.Length), new ParallelOptions {
				MaxDegreeOfParallelism = 4, CancellationToken = budget.Token
			}, async (index, token) => {
				var rssUrl = friends[index].RssUrl;
				if (string.IsNullOrWhiteSpace(rssUrl)) return;
				try {
					var metadata = await feedMetadataReader.ReadAsync(rssUrl, token);
					token.ThrowIfCancellationRequested();
					var item = items[index];
					items[index] = item with {
						Name = string.IsNullOrWhiteSpace(metadata.Name) ? item.Name : metadata.Name,
						Description = string.IsNullOrWhiteSpace(metadata.Description) ? item.Description : metadata.Description,
						Url = string.IsNullOrWhiteSpace(metadata.Url) ? item.Url : metadata.Url,
						Avatar = string.IsNullOrWhiteSpace(metadata.Avatar) ? item.Avatar : metadata.Avatar
					};
				} catch (OperationCanceledException) when (!token.IsCancellationRequested) {
				} catch (Exception exception) when (exception is HttpRequestException or IOException or InvalidDataException or XmlException or ArgumentException) {
				}
			});
		} catch (OperationCanceledException) when (budget.IsCancellationRequested && !cancellationToken.IsCancellationRequested) {
		}
		cancellationToken.ThrowIfCancellationRequested();
		return new(items, page.PageNumber, page.PageSize, page.TotalCount);
	}
}
