namespace Mint.Blog.Model.Vos;

public sealed record PagedResult<T>(
	IReadOnlyCollection<T> Items,
	int PageNumber,
	int PageSize,
	int TotalCount);
