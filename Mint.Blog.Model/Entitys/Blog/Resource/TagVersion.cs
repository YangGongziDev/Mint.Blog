namespace Mint.Blog.Model.Entitys.Blog.Resource;

public sealed class TagVersion(long id, long tagId, string name, long sort, bool isGeneral, bool isDeleted = false) {
    public long Id { get; } = id;
    public long TagId { get; private set; } = tagId;
    public string Name { get; private set; } = name;
    public long Sort { get; private set; } = sort;
    public bool IsGeneral { get; } = isGeneral;
    public bool IsDeleted { get; private set; } = isDeleted;
    public void MoveToTag(long tagId){
        if (IsGeneral && TagId != tagId) throw new InvalidOperationException("通用版本不能更改所属标签。");
        TagId = tagId;
    }
    public void Update(string name, long sort){
        Name = name;
        Sort = sort;
    }
    public void Delete(){
        if (IsGeneral) throw new InvalidOperationException("通用版本不能删除。");
        IsDeleted = true;
    }
}
