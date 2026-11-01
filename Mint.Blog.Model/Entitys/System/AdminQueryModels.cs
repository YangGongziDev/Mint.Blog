namespace Mint.Blog.Model.Entitys.System;

public sealed class IdentityRow {
    public long Id { get; set; }
    public string Username { get; set; } = "";
    public string RealName { get; set; } = "";
    public string Email { get; set; } = "";
    public string Phone { get; set; } = "";
    public string Avatar { get; set; } = "";
    public string Status { get; set; } = "active";
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
}
public sealed class RoleRow {
    public long Id { get; set; }
    public string Name { get; set; } = "";
    public string Code { get; set; } = "";
    public string Description { get; set; } = "";
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
}
public sealed class PermissionRow {
    public long Id { get; set; }
    public string Name { get; set; } = "";
    public string Code { get; set; } = "";
    public string Description { get; set; } = "";
    public string Resource { get; set; } = "";
    public string Action { get; set; } = "";
    public string Type { get; set; } = "menu";
    public long? Parent_Id { get; set; }
    public string? Path { get; set; }
    public string? Component { get; set; }
    public string? Icon { get; set; }
    public int Sort { get; set; }
    public string Status { get; set; } = "active";
    public bool Visible { get; set; }
}
public sealed class RolePermissionRow { public long RoleId { get; set; } public long PermissionId { get; set; } }
public sealed class UserRoleLink { public long UserId { get; set; } public long RoleId { get; set; } }
