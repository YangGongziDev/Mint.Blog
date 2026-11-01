using System.Net.Mail;
using Mint.Blog.Common.Constants;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Model.Dtos.Blog.Message;
using Mint.Blog.Model.Entitys.Blog.Message;
using Mint.Blog.Model.Vos;
using Mint.Blog.Model.Vos.Blog.Message;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Service.IService.Blog;

namespace Mint.Blog.Service.Services.Blog;

public sealed class MessageService(IMessageRepository messageRepository) : IMessageService {
	public Task<PagedResult<MessageListItemVo>> GetAsync(GetMessageListRequest query, CancellationToken cancellationToken = default) => messageRepository.GetAsync(query, cancellationToken);

	public async Task<long> PublishAsync(PublishMessageCommand command, CancellationToken cancellationToken = default){
		Guard.Against(string.IsNullOrWhiteSpace(command.Nickname), ErrorCodes.MessageNicknameInvalid, "昵称不能为空");
		Guard.Against(string.IsNullOrWhiteSpace(command.Content), ErrorCodes.MessageContentInvalid, "留言内容不能为空");
		var email = command.Email?.Trim();
		if (!string.IsNullOrWhiteSpace(email))
			Guard.Against(!MailAddress.TryCreate(email, out _), ErrorCodes.MessageEmailInvalid, "邮箱格式不正确");
		var website = command.Website?.Trim();
		var color = string.IsNullOrWhiteSpace(command.Color) ? "#18b57f" : command.Color.Trim();
		var now = DateTimeOffset.UtcNow;
		var message = new MessageDataModel {
			Nickname = command.Nickname.Trim(), Email = email, Website = website,
			Content = command.Content.Trim(), Color = color, IsPublished = true, CreatedAt = now, UpdatedAt = now
		};
		return await messageRepository.AddAsync(message, cancellationToken);
	}
}
