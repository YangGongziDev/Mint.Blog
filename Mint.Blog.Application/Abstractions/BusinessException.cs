namespace Mint.Blog.Application.Abstractions;

public sealed class BusinessException(string errorCode, string message) : Exception(message) {
	public string ErrorCode { get; } = errorCode;
}