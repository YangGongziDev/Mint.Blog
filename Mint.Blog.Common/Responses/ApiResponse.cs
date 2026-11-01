using Mint.Blog.Common.Constants;

namespace Mint.Blog.Common.Responses;

public sealed record ApiResponse<T>(bool Success, T? Data, string? ErrorCode = null, string? Message = null) {
	public int Code => Success ? 200 : ErrorCode switch {
		ErrorCodes.LoginInvalid or ErrorCodes.Unauthorized or ErrorCodes.TokenExpired or ErrorCodes.RefreshTokenInvalid => 401,
		ErrorCodes.Forbidden => 403,
		"data_conflict" => 409,
		ErrorCodes.InternalServerError => 500,
		_ => 400
	};

	public static ApiResponse<T> Ok(T? data, string? message = null) => new(true, data, null, message ?? "成功");
	public static ApiResponse<T> Fail(string errorCode, string message, T? data = default) => new(false, data, errorCode, message);
}
