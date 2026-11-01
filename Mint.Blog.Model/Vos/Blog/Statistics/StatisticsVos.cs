namespace Mint.Blog.Model.Vos.Blog.Statistics;

public sealed record BlogStatisticsDto(long ArticleTotalCount, long CategoryTotalCount, long TagTotalCount, long ColumnTotalCount, long PvTotalCount);
public sealed record AdminDashboardStatisticsDto(long ArticleTotalCount, long CategoryTotalCount, long TagTotalCount, long ColumnTotalCount, long PvTotalCount);
public sealed record AdminDashboardPvStatisticsDto(IReadOnlyCollection<string> PvDates, IReadOnlyCollection<long> PvCounts);
public sealed record AdminDashboardPublishArticleStatisticsDto(IReadOnlyCollection<string> Dates, IReadOnlyCollection<long> Counts);
public sealed class ArticlePublishDateRow {
    public DateTimeOffset CreatedAt { get; set; }
}
public sealed class ArticleStatisticsRow {
    public long ArticleTotalCount { get; set; }
    public long PvTotalCount { get; set; }
}
