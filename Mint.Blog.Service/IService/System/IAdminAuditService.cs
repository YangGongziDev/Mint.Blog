using System.Text.Json.Nodes;

namespace Mint.Blog.Service.IService.System;

public interface IAdminAuditService {
    Task RecordLogAsync(string resource, JsonObject entry);
}
