namespace Mint.Blog.Domain.Blog.Category.Entities;

public sealed class Category {
	public Category(long id, string name){
		Id = id;
		Name = name;
	}

	public long Id { get; private set; }
	public string Name { get; private set; }
}