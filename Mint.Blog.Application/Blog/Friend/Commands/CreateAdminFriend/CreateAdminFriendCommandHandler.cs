using Mint.Blog.Application.Abstractions;
using FriendEntity = Mint.Blog.Domain.Blog.Friend.Entities.Friend;
using Mint.Blog.Domain.Blog.Friend.Repositories;
using Mint.Blog.Domain.Common.ValueObjects;

namespace Mint.Blog.Application.Blog.Friend.Commands.CreateAdminFriend;

public sealed class CreateAdminFriendCommandHandler(IFriendRepository friendRepository) {
	public async Task<long> HandleAsync(CreateAdminFriendCommand command,
		CancellationToken cancellationToken = default){
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

		var friend = FriendEntity.CreateAdmin(
			command.Name.Trim(),
			command.Avatar.Trim(),
			command.Category.Trim(),
			url,
			command.Description.Trim(),
			email);

		return await friendRepository.AddAsync(friend, cancellationToken);
	}

	private static string NormalizeUrl(string url){
		try {
			return WebsiteUrl.Create(url).Value;
		}
		catch (ArgumentException) {
			throw new BusinessException(ErrorCodes.FriendUrlInvalid, "Friend url is invalid.");
		}
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
