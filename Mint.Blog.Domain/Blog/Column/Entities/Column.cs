using Mint.Blog.Domain.Common;
using Mint.Blog.Domain.Blog.Column.Events;

namespace Mint.Blog.Domain.Blog.Column.Entities;

public sealed class Column : AggregateRoot<long> {
	public Column(){
		Title = string.Empty;
		Summary = string.Empty;
		Cover = string.Empty;
		CreatedAt = DateTimeOffset.UtcNow;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	private Column(
		long id,
		string title,
		string summary,
		string cover,
		bool isDeleted,
		int weight,
		bool isPublish,
		int sort,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		Id = id;
		Title = title;
		Summary = summary;
		Cover = cover;
		IsDeleted = isDeleted;
		Weight = weight;
		IsPublish = isPublish;
		Sort = sort;
		CreatedAt = createdAt;
		UpdatedAt = updatedAt;
	}

	public override long Id { get; protected set; }
	public string Title { get; private set; }
	public string Summary { get; private set; }
	public string Cover { get; private set; }
	public bool IsDeleted { get; private set; }
	public int Weight { get; private set; }
	public bool IsPublish { get; private set; }
	public int Sort { get; private set; }
	public DateTimeOffset CreatedAt { get; private set; }
	public DateTimeOffset UpdatedAt { get; private set; }

	public static Column Create(string title, string summary, string cover){
		var now = DateTimeOffset.UtcNow;
		return new Column(0, title, summary, cover, false, 0, true, 0, now, now);
	}

	public static Column Rehydrate(
		long id,
		string title,
		string summary,
		string cover,
		bool isDeleted,
		int weight,
		bool isPublish,
		int sort,
		DateTimeOffset createdAt,
		DateTimeOffset updatedAt){
		return new Column(id, title, summary, cover, isDeleted, weight, isPublish, sort, createdAt, updatedAt);
	}

	public void Update(string title, string summary, string cover){
		Title = title;
		Summary = summary;
		Cover = cover;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void SetPublish(bool isPublish){
		if (IsPublish == isPublish) return;

		IsPublish = isPublish;
		UpdatedAt = DateTimeOffset.UtcNow;

		if (isPublish)
			AddDomainEvent(new ColumnPublishedDomainEvent(Id, UpdatedAt));
	}

	public void SetTop(bool isTop, int maxWeight){
		Weight = isTop ? maxWeight + 1 : 0;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void SetSort(int sort){
		Sort = sort;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void MarkDeleted(){
		if (IsDeleted) return;

		IsDeleted = true;
		UpdatedAt = DateTimeOffset.UtcNow;
	}

	public void Restore(){
		if (!IsDeleted) return;

		IsDeleted = false;
		UpdatedAt = DateTimeOffset.UtcNow;
	}
}