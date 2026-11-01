namespace Mint.Blog.Model.Options;

public sealed class PostgreSqlOptions {
	public const string SectionName = "PostgreSql";

	public string ConnectionString { get; set; } = string.Empty;
}
