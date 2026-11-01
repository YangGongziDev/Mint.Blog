namespace Mint.Blog.Model.Options;

public sealed class SiteOptions {
    public const string SectionName = "Site";

    public string Url { get; set; } = string.Empty;
    public string? FeedUrl { get; set; }
}
