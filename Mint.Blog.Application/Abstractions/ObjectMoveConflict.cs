namespace Mint.Blog.Application.Abstractions;

public sealed record ObjectMoveConflict(
	string SourceUrl,
	string SourceBucketName,
	string SourceObjectName,
	string TargetBucketName,
	string TargetObjectName,
	string TargetUrl,
	bool CanOverwrite);
