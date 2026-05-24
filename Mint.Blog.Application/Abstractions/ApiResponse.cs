namespace Mint.Blog.Application.Abstractions;

public sealed record ApiResponse<T>(bool Success, T? Data, string? ErrorCode = null, string? Message = null) {
	public static ApiResponse<T> Ok(T? data, string? message = null){
		return new ApiResponse<T>(true, data, null, message);
	}

	public static ApiResponse<T> Fail(string errorCode, string message, T? data = default){
		return new ApiResponse<T>(false, data, errorCode, message);
	}
}
