using Mint.Blog.Domain.Blog.Article.Events;
using Mint.Blog.Domain.Blog.Article.ValueObjects;
using Mint.Blog.Domain.Common;

namespace Mint.Blog.Domain.Blog.Article.Entities;

public sealed class Article : AggregateRoot<long> {
	private readonly List<long> _tagIds = [];

	public Article(){
		Title = string.Empty;
		Summary = string.Empty;
		Content = string.Empty;
		Cover = string.Empty;
		CreatedAt = DateTimeOffset.UtcNow;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	private Article(
		long id,
		string title,
		string summary,
		string content,
		string cover,
		long categoryId,
		IEnumerable<long> tagIds,
		bool isTop,
		ArticleVisibility visibility,
		bool isDeleted,
		long readCount,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		Id = id;
		Title = title;
		Summary = summary;
		Content = content;
		Cover = cover;
		CategoryId = categoryId;
		_tagIds.AddRange(tagIds.Distinct());
		IsTop = isTop;
		Visibility = visibility;
		IsDeleted = isDeleted;
		ReadCount = readCount;
		CreatedAt = createdAt;
		UpdatedAt = updatedAt;
	}

	public override long Id { get; protected set; }

	public string Title { get; private set; }
	public string Summary { get; private set; }
	public string Content { get; private set; }
	public string Cover { get; private set; }
	public long CategoryId { get; private set; }
	public IReadOnlyCollection<long> TagIds => _tagIds.AsReadOnly();
	public bool IsTop { get; private set; }
	public ArticleVisibility Visibility { get; private set; }
	public bool IsDeleted { get; private set; }
	public long ReadCount { get; private set; }
	public DateTimeOffset CreatedAt { get; private set; }
	public DateTimeOffset UpdatedAt { get; private set; }

	public static Article Create(
		string title,
		string summary,
		string content,
		string cover,
		long categoryId,
		IEnumerable<long> tagIds,
		ArticleVisibility visibility){
		var now = DateTimeOffset.UtcNow;
		var article = new Article(
			0,
			ArticleTitle.Create(title).Value,
			ArticleSummary.Create(summary).Value,
			ArticleContent.Create(content).Value,
			ArticleCover.Create(cover).Value,
			categoryId,
			tagIds,
			false,
			visibility,
			false,
			0,
			now,
			now);

		article.AddDomainEvent(new ArticleCreatedDomainEvent(article.Id, now));
		return article;
	}

	public static Article Rehydrate(
		long id,
		string title,
		string summary,
		string content,
		string cover,
		long categoryId,
		IEnumerable<long> tagIds,
		bool isTop,
		ArticleVisibility visibility,
		bool isDeleted,
		long readCount,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		return new Article(
			id,
			title,
			summary,
			content,
			cover,
			categoryId,
			tagIds,
			isTop,
			visibility,
			isDeleted,
			readCount,
			createdAt,
			updatedAt);
	}

	public void Update(
		string title,
		string summary,
		string content,
		string cover,
		long categoryId,
		IEnumerable<long> tagIds,
		ArticleVisibility visibility){
		Title = ArticleTitle.Create(title).Value;
		Summary = ArticleSummary.Create(summary).Value;
		Content = ArticleContent.Create(content).Value;
		Cover = ArticleCover.Create(cover).Value;
		CategoryId = categoryId;
		_tagIds.Clear();
		_tagIds.AddRange(tagIds.Distinct());
		Visibility = visibility;
		UpdatedAt = DateTimeOffset.UtcNow;
		AddDomainEvent(new ArticleUpdatedDomainEvent(Id, UpdatedAt));
	}

	public void MarkDeleted(){
		IsDeleted = true;
		UpdatedAt = DateTimeOffset.UtcNow;
		AddDomainEvent(new ArticleDeletedDomainEvent(Id, UpdatedAt));
	}

	public void SetTop(bool isTop){
		IsTop = isTop;
		UpdatedAt = DateTimeOffset.UtcNow;
		AddDomainEvent(new ArticleTopChangedDomainEvent(Id, IsTop, UpdatedAt));
	}

	public void SetVisibility(ArticleVisibility visibility){
		Visibility = visibility;
		UpdatedAt = DateTimeOffset.UtcNow;
		AddDomainEvent(new ArticleVisibilityChangedDomainEvent(Id, Visibility, UpdatedAt));
	}

	public void IncreaseReadCount(){
		ReadCount += 1;
		AddDomainEvent(new ArticleReadTrackedDomainEvent(Id, ReadCount, DateTimeOffset.UtcNow));
	}
}
