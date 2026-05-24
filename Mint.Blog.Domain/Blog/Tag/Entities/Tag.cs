namespace Mint.Blog.Domain.Blog.Tag.Entities;

public sealed class Tag {
	public Tag(long id, string name){
		Id = id;
		Name = name;
	}

	public long Id { get; private set; }
	public string Name { get; private set; }
}