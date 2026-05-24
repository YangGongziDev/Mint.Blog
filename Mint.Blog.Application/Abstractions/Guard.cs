namespace Mint.Blog.Application.Abstractions;

public static class Guard {
	public static void Against(bool condition, string errorCode, string message){
		if (condition) throw new BusinessException(errorCode, message);
	}
}