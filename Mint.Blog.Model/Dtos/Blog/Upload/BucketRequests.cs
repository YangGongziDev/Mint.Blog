namespace Mint.Blog.Model.Dtos.Blog.Upload;

public sealed record CreateBucketRequest(string BucketName, bool IsPublic);
public sealed record SetBucketPublicRequest(bool IsPublic);
