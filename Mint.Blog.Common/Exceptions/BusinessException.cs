namespace Mint.Blog.Common.Exceptions;

public sealed class BusinessException(string errorCode, string message) : Exception(message) {
	public string ErrorCode { get; } = errorCode;
}
