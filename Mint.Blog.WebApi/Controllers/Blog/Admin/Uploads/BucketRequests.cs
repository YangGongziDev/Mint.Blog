namespace Mint.Blog.WebApi.Controllers.Blog.Admin.Uploads;

public sealed record CreateBucketRequest(string BucketName, bool IsPublic);
public sealed record SetBucketPublicRequest(bool IsPublic);
