using SqlSugar;

namespace Mint.Blog.Infrastructure.Blog.Statistics.Persistence;

[SugarTable("blog_statistics_article_pv")]
public sealed class StatisticsArticlePvDataModel {
	[SugarColumn(IsPrimaryKey = true, ColumnName = "id")]
	public long Id { get; set; }

	[SugarColumn(ColumnName = "pv_date")]
	public DateOnly PvDate { get; set; }

	[SugarColumn(ColumnName = "pv_count")]
	public long PvCount { get; set; }

	[SugarColumn(ColumnName = "create_time")]
	public DateTime CreatedAt { get; set; }

	[SugarColumn(ColumnName = "update_time")]
	public DateTime UpdatedAt { get; set; }
}