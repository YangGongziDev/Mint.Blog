namespace Mint.Blog.Model.Entitys.Blog.Resource;

public sealed class Resource(long id, long tagId, long tagVersionId, string title, string description, string url, int kind,
    bool isFeatured, long sort, bool isDeleted = false) {
    public long Id { get; } = id;
    public long TagId { get; private set; } = tagId;
    public long TagVersionId { get; private set; } = tagVersionId;
    public string Title { get; private set; } = title;
    public string Description { get; private set; } = description;
    public string Url { get; private set; } = url;
    public int Kind { get; private set; } = kind;
    public bool IsFeatured { get; private set; } = isFeatured;
    public long Sort { get; private set; } = sort;
    public bool IsDeleted { get; private set; } = isDeleted;
    public void Update(long tagId, long tagVersionId, string title, string description, string url, int kind, bool isFeatured, long sort){
        if (tagId <= 0 || tagVersionId <= 0) throw new ArgumentException("必须选择实际标签和版本。");
        TagId = tagId;
        TagVersionId = tagVersionId;
        Title = title;
        Description = description;
        Url = url;
        Kind = kind;
        IsFeatured = isFeatured;
        Sort = sort;
    }
    public void Delete() => IsDeleted = true;
    public void Restore() => IsDeleted = false;
}
