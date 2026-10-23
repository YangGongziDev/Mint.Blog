using Mint.Blog.Application.Abstractions;
using FriendEntity = Mint.Blog.Domain.Blog.Friend.Entities.Friend;
using Mint.Blog.Domain.Blog.Friend.Repositories;
using Mint.Blog.Domain.Common.ValueObjects;

namespace Mint.Blog.Application.Blog.Friend.Commands.ApplyFriend;

public sealed class ApplyFriendCommandHandler(
	IFriendRepository friendRepository,
	IDomainEventDispatcher domainEventDispatcher) {
	public async Task<long> HandleAsync(ApplyFriendCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Name), ErrorCodes.FriendNameInvalid,
			"Friend name is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Avatar), ErrorCodes.FriendAvatarInvalid,
			"Friend avatar is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Category), ErrorCodes.FriendCategoryInvalid,
			"Friend category is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Url), ErrorCodes.FriendUrlInvalid, "Friend url is required.");
		Guard.Against(string.IsNullOrWhiteSpace(command.Description), ErrorCodes.FriendDescriptionInvalid,
			"Friend description is required.");

		var url = NormalizeUrl(command.Url);
		var email = NormalizeEmail(command.Email);
		var rssUrl = NormalizeRssUrl(command.RssUrl);

		var friend = FriendEntity.Create(
			command.Name.Trim(),
			command.Avatar.Trim(),
			command.Category.Trim(),
			url,
			command.Description.Trim(),
			email,
			rssUrl);

		var friendId = await friendRepository.AddAsync(friend, cancellationToken);
		await domainEventDispatcher.DispatchAsync(friend.DomainEvents, cancellationToken);
		friend.ClearDomainEvents();
		return friendId;
	}

	private static string NormalizeUrl(string url){
		try {
			return WebsiteUrl.Create(url).Value;
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.FriendUrlInvalid, "Friend url is invalid.");
		}
	}

	private static string? NormalizeRssUrl(string? rssUrl){
		if (string.IsNullOrWhiteSpace(rssUrl)) return null;

		var normalizedUrl = rssUrl.Trim();
		Guard.Against(normalizedUrl.Length > 1000, ErrorCodes.FriendRssUrlInvalid,
			"Friend RSS url cannot exceed 1000 characters.");
		Guard.Against(!Uri.TryCreate(normalizedUrl, UriKind.Absolute, out var uri)
			|| (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps),
			ErrorCodes.FriendRssUrlInvalid, "Friend RSS url must be an HTTP/HTTPS url.");
		return WebsiteUrl.Create(normalizedUrl).Value;
	}

	private static string NormalizeEmail(string? email){
		try {
			return EmailAddress.CreateOptional(email).Value;
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.FriendEmailInvalid, "Friend email is invalid.");
		}
	}
}
