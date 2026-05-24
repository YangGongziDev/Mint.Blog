using MessageEntity = Mint.Blog.Domain.Blog.Message.Entities.Message;
using System.Net.Mail;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Domain.Blog.Message.Repositories;

namespace Mint.Blog.Application.Blog.Message.Commands.PublishMessage;

public sealed class PublishMessageCommandHandler(IMessageRepository messageRepository) {
	public async Task<long> HandleAsync(PublishMessageCommand command,
		CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Nickname), ErrorCodes.MessageNicknameInvalid,
			"昵称不能为空");
		Guard.Against(string.IsNullOrWhiteSpace(command.Content), ErrorCodes.MessageContentInvalid,
			"留言内容不能为空");

		var email = command.Email?.Trim();
		if (!string.IsNullOrWhiteSpace(email))
			Guard.Against(!MailAddress.TryCreate(email, out _), ErrorCodes.MessageEmailInvalid,
				"邮箱格式不正确");

		var website = command.Website?.Trim();
		var color = string.IsNullOrWhiteSpace(command.Color) ? "#18b57f" : command.Color.Trim();

		var message = MessageEntity.Create(
			command.Nickname.Trim(),
			email,
			website,
			command.Content.Trim(),
			color);

		return await messageRepository.AddAsync(message, cancellationToken);
	}
}
